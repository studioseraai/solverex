import { readFileSync, existsSync } from "node:fs";
import assert from "node:assert/strict";

const files = ["app/layout.tsx", "app/page.tsx", "app/globals.css", "app/workspace/page.tsx", "app/workspace/workspace.css"];
for (const path of files) assert.ok(existsSync(path), `Missing required file: ${path}`);
const home = readFileSync("app/page.tsx", "utf8");
const workspace = readFileSync("app/workspace/page.tsx", "utf8");
const readme = readFileSync("README.md", "utf8");
assert.ok(home.includes('href="/workspace"'), "Homepage must link to workspace");
for (const label of ["Explore", "My Requests", "Offers to Help", "Saved", "Review Queue", "Profile"]) {
 assert.ok(workspace.includes(label), `Missing workspace feature: ${label}`);
}
for (const feature of ["localStorage", "makePost", "makeOffer", "makeReport", "resetDemo", "onImage"]) {
 assert.ok(workspace.includes(feature), `Missing demo functionality: ${feature}`);
}
assert.ok(readme.includes("No real financial transactions"), "Preview limitations must be documented");
console.log("Solverex preview smoke checks passed.");
