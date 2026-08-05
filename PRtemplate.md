## Summary
<!-- Briefly describe what this PR includes (user stories, features, bug fixes) -->

## Promotion Details
- **Promotion ID:**
- **Target Environment:**
- **User Stories:**

---

## Release Readiness Checklist

### Org Credentials & Access
- [ ] All target org credentials validated and OAuth tokens active
- [ ] Deployment user has `ModifyMetadata` permission on target org
- [ ] Copado permission sets assigned to all relevant users
- [ ] Connected App is active and not revoked in target org

### User Stories
- [ ] All user stories set to `Promote Change = true`
- [ ] No duplicate metadata across user stories
- [ ] All user stories committed — no pending uncommitted changes
- [ ] User story statuses are correct (not locked/cancelled)

### Metadata Hygiene
- [ ] No merge conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`) in any XML files
- [ ] Profile/PermissionSet XML files are well-formed and not truncated
- [ ] `SecuritySettings` does not include `EnableMFADirectUILoginOptIn` if MFA is org-enforced
- [ ] Destructive changes reviewed and intentional
- [ ] No missing referenced metadata (e.g. RecordTypes with no backing XML file)

### Duplicate Check
- [ ] No same component in multiple user stories in the same promotion
- [ ] Self-duplicates within a single user story cleaned up

---

### Promotion Setup
- [ ] Correct pipeline/environment selected
- [ ] Promotion branch is up to date with target branch
- [ ] Back merge completed from target if target has diverged
- [ ] All user stories belong to the same pipeline
- [ ] Snapshot of target org taken before deployment

---

### Deployment Execution
- [ ] Validate Only deployment passed with 0 errors
- [ ] Apex test results pass
- [ ] Quick Deploy used if validation job ID is still valid (within 10 days)

---

### Post-Deployment
- [ ] Deployment status confirmed as **Succeeded** in Copado and SF Setup
- [ ] Smoke test completed on key features in target org
- [ ] Permissions verified in target org (Profiles, Permission Sets)
- [ ] Manual post-deploy steps completed (data updates, custom settings, etc.)
- [ ] Backup snapshot of target org taken after deployment
- [ ] User stories marked as **Deployed**

---

### Rollback Plan
- [ ] Pre-deployment snapshot available to restore from
- [ ] Destructive changes rollback package prepared if needed
- [ ] Stakeholders notified of rollback procedure
