#!/usr/bin/env node
// Re-injects SESSION.md every N prompts if it exists in the current working directory.
// Uses a per-session counter in /tmp/ so injection is scoped to the active session.

const fs = require('fs');
const path = require('path');
const os = require('os');

const N = 20;

let input = '';
process.stdin.on('data', d => (input += d));
process.stdin.on('end', () => {
  try {
    const data = JSON.parse(input || '{}');
    const sessionId = data.session_id || 'default';

    const counterFile = path.join(os.tmpdir(), `claude-prompt-count-${sessionId}`);

    let count = 0;
    try {
      count = parseInt(fs.readFileSync(counterFile, 'utf8'), 10) || 0;
    } catch {}

    count++;
    fs.writeFileSync(counterFile, String(count));

    if (count % N !== 0) {
      process.stdout.write('{}');
      process.exit(0);
    }

    const sessionFile = path.join(process.cwd(), 'SESSION.md');
    if (!fs.existsSync(sessionFile)) {
      process.stdout.write('{}');
      process.exit(0);
    }

    const content = fs.readFileSync(sessionFile, 'utf8').trim();

    process.stdout.write(
      JSON.stringify({
        hookSpecificOutput: {
          hookEventName: 'UserPromptSubmit',
          additionalContext: `[SESSION.md re-injected at prompt ${count}]\n\n${content}`,
        },
      })
    );
  } catch {
    process.stdout.write('{}');
  }
  process.exit(0);
});
