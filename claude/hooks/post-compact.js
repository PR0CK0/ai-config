#!/usr/bin/env node
/**
 * post-compact — PostCompact hook (advisory, exit 0)
 *
 * After context compaction, re-injects SESSION.md from the working directory
 * so Claude picks up where it left off without losing structured session context.
 *
 * Returns additionalContext if SESSION.md exists; silent otherwise.
 */

import { readFileSync, existsSync } from 'node:fs';
import { join } from 'node:path';

let input = '';
try { input = readFileSync('/dev/stdin', 'utf8').trim(); } catch { process.exit(0); }
if (!input) process.exit(0);

let data;
try { data = JSON.parse(input); } catch { process.exit(0); }

const cwd = data?.cwd;
if (!cwd) process.exit(0);

const sessionFile = join(cwd, 'SESSION.md');
if (!existsSync(sessionFile)) process.exit(0);

let content;
try { content = readFileSync(sessionFile, 'utf8').trim(); } catch { process.exit(0); }
if (!content) process.exit(0);

console.log(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: 'PostCompact',
    additionalContext: `[Session context restored from SESSION.md after compaction]\n\n${content}`,
  }
}));

process.exit(0);
