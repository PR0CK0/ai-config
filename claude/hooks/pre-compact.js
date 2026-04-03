#!/usr/bin/env node
/**
 * pre-compact — PreCompact hook (advisory, exit 0)
 *
 * Backs up the session transcript before context compaction.
 * Compaction is lossy — this preserves the original JSONL.
 *
 * Backups written to: ~/.claude/backups/<timestamp>-<session-id>.jsonl
 */

import { readFileSync, existsSync, mkdirSync, copyFileSync } from 'node:fs';
import { join } from 'node:path';
import { homedir } from 'node:os';

let input = '';
try { input = readFileSync('/dev/stdin', 'utf8').trim(); } catch { process.exit(0); }
if (!input) process.exit(0);

let data;
try { data = JSON.parse(input); } catch { process.exit(0); }

const sessionId = data?.session_id;
const cwd = data?.cwd;
if (!sessionId || !cwd) process.exit(0);

// Match Claude's project directory naming: replace path separators with dashes
const sanitized = cwd.replaceAll('/', '-').replace(/^-/, '');
const transcriptPath = join(homedir(), '.claude', 'projects', sanitized, `${sessionId}.jsonl`);

if (!existsSync(transcriptPath)) process.exit(0);

const backupDir = join(homedir(), '.claude', 'backups');
mkdirSync(backupDir, { recursive: true });

const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
const backupPath = join(backupDir, `${timestamp}-${sessionId}.jsonl`);

try {
  copyFileSync(transcriptPath, backupPath);
  console.error(`[pre-compact] Transcript backed up → ${backupPath}`);
} catch { /* silent */ }

process.exit(0);
