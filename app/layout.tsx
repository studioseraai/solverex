import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Solverex — Every problem deserves a solution",
  description: "A place to share real problems and find people ready to help through resources, skills and support.",
  robots: { index: false, follow: false },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="en"><body>{children}</body></html>;
}
