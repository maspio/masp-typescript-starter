//https://github.com/wallabyjs/wallaby-jest-snapshots/blob/typescript/wallaby.js
module.exports = function (wallaby) {
  return {
    files: [
      'src/**/*.ts',
      '!src/**/*.spec.ts'
    ],

    tests: [
      'src/**/*.spec.ts'
    ],

    env: {
      type: 'node'
    },

    testFramework: 'ava'
  };
};