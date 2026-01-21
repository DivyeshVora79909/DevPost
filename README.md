# DevPost

nhost init
nhost login
nhost link
nhost up
nhost db migrate up

1. Project setup & authentication
   | Command | Purpose | Notes / Usage |
   | -------------- | --------------------------------------- | --------------------------------------------------------------------------- |
   | `nhost login` | Log in to Nhost | Choose **PAT** for CI-friendly, GUI-free workflow |
   | `nhost logout` | Log out from current session | Useful if switching accounts |
   | `nhost init` | Initialize Nhost in a local repo | Creates `.nhost/` and `nhost.config.js` (local config only) |
   | `nhost link` | Link local repo to a **remote project** | Confirms project subdomain → all migrations/deployments target this project |

2. Database / migrations
   | Command | Purpose | Notes / Usage |
   | -------------------------------- | -------------------------------- | -------------------------------------------------------- |
   | `nhost db migrate create <name>` | Create a new migration file | Generates a timestamped SQL file in `migrations/` folder |
   | `nhost db migrate up` | Apply **all pending migrations** | Executes them on **remote Nhost Postgres** |
   | `nhost db migrate down` | Rollback the last migration | Use carefully; affects remote DB |
   | `nhost db status` | Show migration status | See which migrations have been applied |

3. Remote project management
   | Command | Purpose | Notes / Usage |
   | ----------------------------------- | ---------------------------------- | -------------------------------------------- |
   | `nhost link --project <project-id>` | Switch to another remote project | Useful for multiple accounts/environments |
   | `nhost whoami` | Show which account / PAT is active | Helps debug multi-account setup |
   | `nhost status` | Check the linked project info | Shows subdomain, region, and active services |

4. GraphQL / Hasura metadata
   | Command | Purpose | Notes / Usage |
   | ----------------------- | ------------------------------------------------- | ------------------------------------------ |
   | `nhost metadata export` | Export Hasura metadata from remote | Store in Git → portable |
   | `nhost metadata apply` | Apply metadata to remote | Used for roles, permissions, relationships |
   | `nhost metadata diff` | See differences between local metadata and remote | Useful before applying |

5. Local development (optional — skip for remote-only)
   | Command | Purpose | Notes / Usage |
   | ------------ | ------------------------------------------------------------ | --------------------------------------------- |
   | `nhost up` | Start local Nhost stack (Postgres + Hasura + Auth + Storage) | Not needed if your goal is **remote-only** |
   | `nhost dev` | Run local development environment | Only for testing; skip for your SSOT workflow |
   | `nhost down` | Stop local stack | N/A for remote-only |

6. Storage (optional for remote)
   | Command | Purpose | Notes / Usage |
   | ------------------------------- | ------------------------------- | --------------------------------- |
   | `nhost storage upload <file>` | Upload a file to remote storage | Targets linked project |
   | `nhost storage download <file>` | Download a file | Remote storage only |
   | `nhost storage list` | List files in bucket | Useful for automation / scripting |
