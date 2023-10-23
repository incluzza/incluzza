# incluzza
A social network to enable persons with disabilities (PwD)

### Tech Stack Selection

Each selection has been made after careful consideration of its advantages in terms of performance, community support, and relevance to our project's goals.

#### **Rust**
- **Performance**: Rust is known for its blazing fast performance, making it suitable for high-performance applications.
- **Memory Safety**: It guarantees memory safety without sacrificing performance.
- **Open Source**: Has a thriving community, which means robust support, many third-party libraries, and frequent updates.
- **Concurrency**: Rust's ownership model ensures safe concurrent execution without race conditions.
- **Modern Syntax**: Offers a modern syntax with powerful features for improved developer productivity.

#### **GraphQL**
- **Flexible Data Retrieval**: Allows clients to specify exactly what data they need, reducing over-fetching or under-fetching of data.
- **Optimal for Content Management and Social Networks**: Especially given the diverse and dynamic data needs of such systems, GraphQL offers more flexibility in querying complex data structures.
- **Evolvable**: You can add fields to your API without affecting existing queries. Old fields can be deprecated and hidden from tools.

#### **Hasura**
- **Instant GraphQL APIs**: Get instant, real-time, and high-performance GraphQL APIs over Postgres without writing any backend code.
- **Fine-grained Access Control**: Define roles and set permissions at a field & row level.
- **Real-time Live Queries**: Hasura gives you live queries with GraphQL subscriptions, making real-time applications a breeze.
- **Long-term Scalability**: Supports real-time live queries, addressing backend scalability concerns as data and user interactions grow.

### Database Selection

In the process of selecting the appropriate database for our project, we underwent a detailed discussion, analyzing the merits and potential pitfalls of both relational databases (specifically PostgreSQL) and NoSQL databases. This document encapsulates that discussion and highlights our reasons for choosing PostgreSQL, while still keeping an eye towards future scalability and adaptability.

#### Initial Argument: In Favor of NoSQL

- Given our use-case of content management and profiles, NoSQL seemed a more intuitive choice.
- NoSQL databases are often favored for their flexibility, which seemed apt for content-driven systems.
- GraphQL is gaining traction, and databases like MongoDB offer libraries (e.g., `graphql-compose-mongoose`) that simplify creating GraphQL APIs over NoSQL.

#### Counter-Argument: In Favor of PostgreSQL

- The functional gap between traditional RDBMS and NoSQL has been narrowing.
- PostgreSQL can effectively handle content management use-cases without the need for automatic sharding.
- Anecdotal evidence: Media website Guardian migrated from MongoDB to Postgres, suggesting the capabilities of PostgreSQL in handling such use-cases.
- PostgreSQL's growing popularity ensures community support and continuous development.
- AWS's Serverless Aurora offers a low-cost, self-managed PostgreSQL solution.
- Also our team's familiarity with PostgreSQL is a significant asset.

#### Revisiting the Argument: Combining Strengths

- Acknowledging the benefits of PostgreSQL in terms of familiarity, cost, and management.
- However, translating GraphQL queries to efficient SQL might pose challenges, especially with nested queries which require multiple joins.
- Tools like Hasura can potentially bridge this gap or inspire a custom solution tailored to our system's needs.

#### Final Thoughts

PostgreSQL helps during the initial product phase, focusing on business logic and initial growth. However, it's essential to ensure scalability and adaptability for future requirements. We can achieve this by considering below points as future avenues for scalability:
  - Use of Redis for caching.
  - Storing large data blobs directly in S3 and linking them in Postgres.
  - PostgreSQL can be utilized for progress tracking.
  - Pushing analytics directly to ClickHouse.
  - Kafka for event streaming.
  - Maintaining our existing tech stack brings consistency and faster development cycles.
  - Potential to integrate Cassandra for event storage and media content indexed by a key, referenceable from Postgres.
  - Options to use text inverted indices like ElasticSearch/Solr for document searching.
  - Data organization for performance:
    - **Configs**: Can be cached entirely in In-Memory Caches (IMC).
    - **Domain Data**: Scalable using read replicas.
    - **Trackers/Events**: Needs separation due to continuous growth. Recent data is crucial, older data can be archived.
    - **Data Modeling**: Modeling data as KV brings us closer to real data organization. SQL might obscure that understanding, especially for trackers. For domains and configs, even SQL results can be cached, as seen with GraphQL caching.
    - **RDBMS**: H. The question remains: does GraphQL aid or hinder this future-forward approach?

#### Conclusion

Based on our extensive discussions, we chose PostgreSQL for our project due to its versatility, our team's familiarity, and the ecosystem benefits it offers. However, we are consciously keeping avenues open for future integrations, ensuring that as our product grows, our tech stack will scale and adapt alongside it.

---

By laying out our discussions in this manner, we aim to provide clarity on our decision-making process and foster a dialogue with the community. We believe in iterative improvements and welcome feedback on our choices.
