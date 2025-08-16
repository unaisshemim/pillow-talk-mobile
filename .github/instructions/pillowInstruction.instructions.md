---
applyTo: '**'
---
Provide project context and coding guidelines that AI should follow when generating code, answering questions, or reviewing changes.

# COPILOT EDITS OPERATIONAL GUIDELINES
                
## PRIME DIRECTIVE
	Avoid working on more than one file at a time.
	Multiple simultaneous edits to a file will cause corruption.
	Be chatting and teach about what you are doing while coding.

## LARGE FILE & COMPLEX CHANGE PROTOCOL

### MANDATORY PLANNING PHASE
	When working with large files (>300 lines) or complex changes:
		1. ALWAYS start by creating a detailed plan BEFORE making any edits
            2. Your plan MUST include:
                   - All functions/sections that need modification
                   - The order in which changes should be applied
                   - Dependencies between changes
                   - Estimated number of separate edits required
                
            3. Format your plan as:
## PROPOSED EDIT PLAN
	Working with: [filename]
	Total planned edits: [number]

### MAKING EDITS
	- Focus on one conceptual change at a time
	- Show clear "before" and "after" snippets when proposing changes
	- Include concise explanations of what changed and why
	- Always check if the edit maintains the project's coding style

### Edit sequence:
	1. [First specific change] - Purpose: [why]
	2. [Second specific change] - Purpose: [why]
	3. Do you approve this plan? I'll proceed with Edit [number] after your confirmation.
	4. WAIT for explicit user confirmation before making ANY edits when user ok edit [number]
            
### EXECUTION PHASE
	- After each individual edit, clearly indicate progress:
		"✅ Completed edit [#] of [total]. Ready for next edit?"
	- If you discover additional needed changes during editing:
	- STOP and update the plan
	- Get approval before continuing
                
### REFACTORING GUIDANCE
	When refactoring large files:
	- Break work into logical, independently functional chunks
	- Ensure each intermediate state maintains functionality
	- Consider temporary duplication as a valid interim step
	- Always indicate the refactoring pattern being applied
                
### RATE LIMIT AVOIDANCE
	- For very large files, suggest splitting changes across multiple sessions
	- Prioritize changes that are logically complete units
	- Always provide clear stopping points
            
## General Requirements
	Use modern technologies as described below for all code suggestions. Prioritize clean, maintainable code with appropriate comments.
            
### Accessibility
	- Ensure compliance with **WCAG 2.1** AA level minimum, AAA whenever feasible.
	- Always suggest:
	- Labels for form fields.
	- Proper **ARIA** roles and attributes.
	- Adequate color contrast.
	- Alternative texts (`alt`, `aria-label`) for media elements.
	- Semantic HTML for clear structure.
	- Tools like **Lighthouse** for audits.
        
## Mobile Compatibility both IOS and Android
    - Ensure responsive design using Flutter's layout widgets.
    - Test on both iOS and Android devices/emulators for compatibility.

## Flutter Requirements

## Target Environment
- **Flutter SDK**:  3.32.8 
- **Dart SDK**: 3.8.1
- **Architecture**: Clean Architecture with Feature-first or Domain-Driven folder structure

---

## ⚙️ Dart & Flutter Features to Use
- Dart 3 Features: Records, Pattern Matching, Sealed Classes, etc.
- Named Constructors and Parameters
- Nullable and Non-nullable Types
- Cascade Notation (`..`) and Null-aware Operators (`?.`, `??`, `??=`, `!`)
- `late` and `final` for immutability
- Collection if / for / spread operators (`...`, `...?`)
- Extension Methods
- Exhaustive `switch` with `enum` members
- Freezed + JsonSerializable for immutability and serialization
- Custom `typedef`s for clarity

---

## 🧑‍💻 Coding Standards
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `riverpod` for state management with `@riverpod` code generation
- Use `freezed` for immutable models and union types
- Use `json_serializable` for `.fromJson()` and `.toJson()`
- Use `hive` for lightweight local storage
- Use `dio` with interceptors and typed responses - use custom apiService
- Prefer composition over inheritance
-select sizes and colors from the constant i have declared

---

## 🚨 Error Handling
- Use `try/catch` with typed exceptions (`DioException`, `HiveError`)
- Avoid using dynamic `catch` blocks
- Provide clear, user-friendly error messages
- Use domain-specific custom exceptions

---

## 🧪 Testing
- Unit testing with `flutter_test`, `mockito`, `riverpod`
- UI/Integration tests with `patrol`
- Write provider and notifier tests
- Test Hive adapters and serialization

---