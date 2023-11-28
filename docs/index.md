## Table of Contents
- [Purpose](#purpose)
- [Goals](#goals)
- [Component Details](#component-details)
- [Building Blocks](#building-blocks)
    - [Database Schema](#database-schema)

## Purpose
*Develop a social network to enable persons with disabilities (PwD) and enablers.*

## Goals
1. Establish Peer to Peer networks of PwD.
2. Connect Enablers like volunteers, NGOs.
3. Provide opportunity roadmaps for PwDs and enablers. 
4. Facilitate resource sharing. 
5. Employers to find candidates.


### Building Blocks
#### Database Schema
##### Table: `users`
| Field | Type | Description |
| -------- | -------- | -------- |
| user_id | int (PK) | Unique identifier for each user |
| username | varchar | User's chosen username |
| .. | .. | .. |

##### Table: `user_connections`
| Field | Type | Description |
| -------- | -------- | -------- |
| connection_id | int (PK) | Unique identifier for each connection |
| user_id | int (FK) | Foreign key referencing the users table |
| .. | .. | .. |

#### Relationships
```mermaid
graph TD;
  Users --> UserConnections;
  Users --> UserPosts;
``````
