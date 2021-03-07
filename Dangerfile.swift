import Danger 
let danger = Danger()

let commits = danger.github.commits
_ = commits.map {
    message("Commit info:")
    message("sha: \($0.sha)")
    message("message: \($0.commit.message)")
    message("author: \($0.commit.author.name)")
}

let assignee = danger.github.pullRequest.assignee
message("Assignee: \(String(describing: assignee))")

let commentCount = danger.github.pullRequest.commentCount
message("Comment Count: \(String(describing: commentCount))")

let createdAt = danger.github.pullRequest.createdAt
message("Created At: \(String(describing: createdAt))")

let additions = danger.github.pullRequest.additions
message("Additions: \(String(describing: additions))")

let deletions = danger.github.pullRequest.deletions
message("Deletions: \(String(describing: deletions))")

let state = danger.github.pullRequest.state
message("State: \(String(describing: state))")

let changedFiles = danger.github.pullRequest.changedFiles
message("Changed Files: \(String(describing: changedFiles))")

let commitCount = danger.github.pullRequest.commitCount
message("Number of commits in MR: \(String(describing: commitCount))")

let requestedReviewers = danger.github.requestedReviewers
message("Requested Reviewers: \(String(describing: requestedReviewers))")

let allModifiedFiles = danger.git.modifiedFiles
message("All modified files: \(allModifiedFiles)")

let hasChangelogEntry = danger.git.modifiedFiles.contains("CHANGELOG.md")
message("Has Changelog Entry: \(hasChangelogEntry)")
