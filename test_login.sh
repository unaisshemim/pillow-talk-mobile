#!/bin/bash

# Script to run login integration tests with Patrol

echo "🧪 Running PillowTalk Login Integration Tests..."
echo "======================================"

# Make sure we're in the project directory
cd "$(dirname "$0")"

# Run the login integration tests
flutter test test/features/auth/login_integration_test.dart --verbose

echo "======================================"
echo "✅ Login tests completed!"
