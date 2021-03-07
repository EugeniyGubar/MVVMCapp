import Danger 
let danger = Danger()

// Print all changed project files
let allEditedFiles = danger.git.modifiedFiles + danger.git.createdFiles
let editedProjectFiles = allEditedFiles.filter { $0.contains("/MVVMCapp") }
message("These files have been changed: \(editedProjectFiles.joined(separator: ", "))")

// Check if there is a CHANGELOG.md in merge request
let hasChangelogEntry = danger.git.modifiedFiles.contains("CHANGELOG.md")

if editedProjectFiles.count > 0 && !hasChangelogEntry {
  fail("Please add a CHANGELOG entry")
}
