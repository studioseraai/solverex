-- Solverex MVP database proposal. Review before executing in your own Supabase project.
-- Personal verification documents must never be stored in public buckets.
create extension if not exists pgcrypto;
create type public.problem_status as enum ('pending','published','in_progress','resolved','rejected');
create type public.help_kind as enum ('resources','expertise','opportunity','other');
create table public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 display_name text not null default 'Member',
 bio text,
 created_at timestamptz not null default now()
);
create table public.problems (
 id uuid primary key default gen_random_uuid(),
 author_id uuid not null references public.profiles(id) on delete cascade,
 title text not null check (char_length(title) between 10 and 120),
 story text not null check (char_length(story) between 15 and 3000),
 category text not null check (category in ('Education','Business','Career','Community','Other')),
 location text,
 need text not null,
 status public.problem_status not null default 'pending',
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create table public.help_offers (
 id uuid primary key default gen_random_uuid(),
 problem_id uuid not null references public.problems(id) on delete cascade,
 helper_id uuid not null references public.profiles(id) on delete cascade,
 kind public.help_kind not null,
 details text not null check (char_length(details) between 10 and 2000),
 created_at timestamptz not null default now(),
 unique(problem_id,helper_id)
);
create table public.problem_reports (
 id uuid primary key default gen_random_uuid(),
 problem_id uuid not null references public.problems(id) on delete cascade,
 reporter_id uuid not null references public.profiles(id) on delete cascade,
 reason text not null check (char_length(reason) between 5 and 500),
 created_at timestamptz not null default now(),
 unique(problem_id,reporter_id)
);
alter table public.profiles enable row level security;
alter table public.problems enable row level security;
alter table public.help_offers enable row level security;
alter table public.problem_reports enable row level security;
create policy "Profiles viewable to authenticated users" on public.profiles for select to authenticated using (true);
create policy "Users insert own profile" on public.profiles for insert to authenticated with check (id = (select auth.uid()));
create policy "Users update own profile" on public.profiles for update to authenticated using (id = (select auth.uid())) with check (id = (select auth.uid()));
create policy "Published problems visible" on public.problems for select to anon, authenticated using (status='published' or author_id=(select auth.uid()));
create policy "Authenticated users submit problems for review" on public.problems for insert to authenticated with check (author_id=(select auth.uid()) and status='pending');
create policy "Authors can edit pending requests" on public.problems for update to authenticated using (author_id=(select auth.uid()) and status='pending') with check (author_id=(select auth.uid()) and status='pending');
create policy "Helpers can view own offers" on public.help_offers for select to authenticated using (helper_id=(select auth.uid()) or exists (select 1 from public.problems p where p.id=problem_id and p.author_id=(select auth.uid())));
create policy "Helpers can offer on published problems" on public.help_offers for insert to authenticated with check (helper_id=(select auth.uid()) and exists (select 1 from public.problems p where p.id=problem_id and p.status='published' and p.author_id<>(select auth.uid())));
create policy "Members can submit reports" on public.problem_reports for insert to authenticated with check (reporter_id=(select auth.uid()));
-- Admin operations intentionally have no browser RLS policies.
-- Implement carefully audited server-only moderation with service_role, never in client code.
