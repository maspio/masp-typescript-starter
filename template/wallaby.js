//https://github.com/wallabyjs/wallaby-jest-snapshots/blob/typescript/wallaby.js
module.exports = function (wallaby) {
  return {
    name: '@PROJECT_SCOPE/PROJECT_NAME',
    files: [
      'src/**/*.ts',
      '!src/**/*.spec.ts',
      'data/**/*.*'
    ],

    tests: [
      'src/**/*.spec.ts'
    ],

    env: {
      type: 'node'
    },
    slowTestThreshold: 200,
    lowCoverageThreshold: 70, // 70%
    testFramework: 'ava'
  };
};
