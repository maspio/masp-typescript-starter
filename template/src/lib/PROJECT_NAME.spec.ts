// tslint:disable:no-expression-statement
// tslint:disable:no-object-mutation

import test from 'ava';
import fs from 'fs';
import path from 'path';

const promiseFn = () => Promise.resolve(true);
const delay = async (millis: number) => new Promise<void>(resolve => setTimeout(resolve, millis));

/**
 * WRITING TESTS
 * https://github.com/avajs/ava/blob/master/docs/01-writing-tests.md
 * 
 * CONTEXT
 * https://github.com/avajs/ava/blob/master/docs/02-execution-context.md
 * 
 * ASSERTIONS
 * https://github.com/avajs/ava/blob/master/docs/03-assertions.md
 */

/**
 * WALLABY APP
 * http://localhost:51245
 */


test('my passing test', t => {
  t.pass();
});

test.serial('passes serially', t => {
  t.pass();
});

test('resolves with unicorn', t => {
  return Promise.resolve('unicorn').then(result => {
    t.is(result, 'unicorn');
  });
});

// ASYNC ARROW
test('Async function', async t => {
  const value = await promiseFn();
  t.true(value);
});

// CALLBACK
test.cb('data.txt can be read', t => {
  // you have to
  const dataFile = path.join('data', 'data.txt');
  fs.readFile(dataFile, t.end);
});

// FAILING
test.failing('demonstrate some bug', t => {
  t.fail(); // Test will count as passed
});

/**
 * ############
 * TEST CONTEXT
 * ############
 */

test.beforeEach(t => {
  t.context = { glitter: 'unicorn' };
});


test('context is unicorn', (t: any) => {
  t.is(t.context.glitter, 'unicorn');
});

/**
 * ####################
 * BEFORE & AFTER HOOKS
 * ####################
 */

test.before(t => {
  // This runs before all tests
  t.pass();
});

test.before(t => {
  // This runs concurrently with the above
  t.pass();
});

test.serial.before(t => {
  // This runs after the above
  t.pass();
});

test.serial.before(t => {
  // This too runs after the above, and before tests
  t.pass();
});

test.after('cleanup', t => {
  // This runs after all tests
  t.pass();
});

test.after.always('guaranteed cleanup', t => {
  // This will always run, regardless of earlier failures
  t.pass();
});

test.beforeEach(t => {
  // This runs before each test
  t.pass();
});

test.afterEach(t => {
  // This runs after each test
  t.pass();
});

test.afterEach.always(t => {
  // This runs after each test and other test hooks, even if they failed
  t.pass();
});

test('title', t => {
  // Regular test
  t.pass();
});

/**
 * ###########
 * ASYNC HOOKS
 * ###########
 */

test.before(async t => {
  await promiseFn().then(() => t.pass());
});

test.after(t => {
  return delay(100).then(() => t.pass());
});

test.beforeEach.cb(t => {
  setTimeout(t.end, 100);
});

test.afterEach.cb(t => {
  setTimeout(t.end, 100);
});