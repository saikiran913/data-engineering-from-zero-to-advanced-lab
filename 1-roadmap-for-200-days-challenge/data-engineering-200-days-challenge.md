# Data Engineering From Zero to Advanced — 200-Day Public Roadmap

A structured public learning journey that begins with complete Data Engineering fundamentals and gradually progresses through SQL, Python, data modelling, orchestration, distributed processing, streaming, lakehouse technologies, cloud platforms, and end-to-end system design.

This roadmap is designed for:

- students
- freshers
- career switchers
- aspiring Data Engineers
- analysts moving towards engineering
- early-career professionals strengthening their foundations

## Current Progress

- **Completed:** Day 001–032
- **Next planned topic:** Day 033
- **Core curriculum target:** Day 200
- **Publishing plan:** approximately five learning days per week
- **Estimated remaining duration:** approximately 9–10 calendar months, allowing time for reviews and capstones

## Roadmap Philosophy

The curriculum follows a gradual progression:

1. Understand what Data Engineering is and how data moves.
2. Build strong SQL and validation habits.
3. Learn the command line, Git, Python, and pandas.
4. Study data modelling, warehouses, lakes, and lakehouses.
5. Build transformation and orchestration skills with dbt and Airflow.
6. Learn production engineering practices such as testing, CI/CD, containers, infrastructure as code, security, governance, and observability.
7. Progress into Spark, Kafka, streaming, CDC, open table formats, cloud platforms, and system design.

The roadmap may receive small updates when official documentation, product names, or industry practices change. The overall learning sequence will remain stable.

## Difficulty Levels

| Level | Day Range | Main Goal |
|---|---:|---|
| Basic | Day 001–060 | Build strong Data Engineering, SQL, command-line, Git, and Python foundations |
| Medium | Day 061–125 | Build practical pipelines, APIs, pandas workflows, data models, dbt projects, Airflow DAGs, and containerised scripts |
| Hard | Day 126–200 | Learn production engineering, distributed processing, streaming, lakehouse platforms, cloud services, and system design |

### Difficulty Milestones

- **Basic level ends after Day 060.**
- **Medium level starts on Day 061 and ends after Day 125.**
- **Hard level starts on Day 126 and completes on Day 200.**

## Roadmap Coverage Map

| Day Range | Theme | Coverage |
|---:|---|---|
| 033–043 | Advanced SQL foundations | Pipeline validation, control totals, completeness, exceptions, schemas, constraints, transactions, indexes, query plans, performance, and JSON |
| 044–049 | Command line and Git | Shell navigation, pipes, scripts, Git fundamentals, branching, merging, and remote collaboration |
| 050–060 | Python foundations | Python setup, data types, conditions, loops, functions, collections, strings, dates, files, reliability, and modules |
| 061–080 | Python pipeline engineering | Files, generators, classes, typing, logging, configuration, testing, APIs, authentication, retries, validation, and ingestion |
| 081–093 | pandas | DataFrames, I/O, cleaning, joins, GroupBy, reshaping, duplicates, types, chunking, pipeline design, and a mini-project |
| 094–114 | Data modelling and storage | Relational modelling, OLTP/OLAP, dimensional modelling, star schemas, SCDs, warehouses, lakes, lakehouses, Parquet, Avro, incremental loading, and CDC |
| 115–120 | dbt and analytics engineering | Models, refs, sources, freshness, tests, documentation, materializations, and snapshots |
| 121–125 | Airflow and Docker foundations | DAGs, scheduling, retries, backfills, containers, Dockerfiles, and reproducible local runs |
| 126–145 | Production engineering foundations | Docker Compose, Kubernetes, CI/CD, Terraform, advanced Airflow and dbt, quality, contracts, lineage, governance, security, observability, incidents, and testing |
| 146–158 | Spark and PySpark | Architecture, DataFrames, schemas, lazy execution, cleaning, joins, aggregations, shuffles, caching, file I/O, query plans, testing, and batch capstones |
| 159–172 | Streaming and CDC | Kafka, producers, consumers, offsets, schemas, Connect, Streams, Structured Streaming, event time, watermarks, state, joins, deduplication, and Debezium |
| 173–182 | Lakehouse technologies | Open table formats, Delta Lake, Iceberg, Hudi, maintenance, catalogues, metastores, and Databricks |
| 183–196 | Cloud and platform engineering | Multi-cloud service mapping, GCP, AWS, Azure, Snowflake, NoSQL, and distributed-systems trade-offs |
| 197–200 | Capstones and final review | Advanced batch, streaming, multi-cloud, and end-to-end system-design portfolio work |

## Completed Foundation — Days 001–032

The first 32 days establish the foundation for the remainder of the roadmap. They cover:

- what Data Engineering is
- how data flows inside organisations
- structured, semi-structured, and unstructured data
- databases, warehouses, and lakes
- ETL and ELT
- batch and streaming concepts
- common data formats
- data-quality fundamentals
- SQL filtering, aggregation, joins, cleaning, dates, unions, duplicates, subqueries, and CTEs
- SQL window functions
- views, reusable interfaces, staging concepts, and safe handoffs

The public roadmap below continues from Day 033.

# Phase 1 — Basic Level

**Range:** Days 001–060  
**Phase purpose:** Build the foundations needed to understand data systems, write dependable SQL, use the command line and Git, and begin writing Python scripts.  
**Milestone:** Basic level ends after Day 060.

- **Day 033 — SQL Pipeline Validation Review: Row Counts, Control Totals, Data Completeness, and Exception Reporting**
- **Day 034 — SQL Control Totals for Data Engineers: Counts, Sums, Boundaries, and Stage Reconciliation**
- **Day 035 — SQL Data Completeness Checks: Required Fields, Missing Keys, Date Coverage, and Expected Records**
- **Day 036 — SQL Exception Reporting: Review Queues, Severity Levels, and Investigable Data-Quality Outputs**
- **Day 037 — SQL Schema Validation: Column Contracts, Data Types, Required Fields, and Change Detection**
- **Day 038 — SQL Constraint Concepts: Primary Keys, Foreign Keys, UNIQUE, CHECK, and NOT NULL**
- **Day 039 — SQL Transactions Fundamentals: Atomicity, COMMIT, ROLLBACK, and Safe Multi-Step Changes**
- **Day 040 — SQL Index Fundamentals: Faster Reads, Write Trade-offs, and Index Selection Thinking**
- **Day 041 — SQL Query Plans for Beginners: EXPLAIN, Table Scans, Join Plans, and Cost Awareness**
- **Day 042 — SQL Performance Habits: Projection, Filtering, Join Reduction, and Avoiding Unnecessary Work**
- **Day 043 — SQL for Semi-Structured Data: JSON Fields, Nested Values, and Validation Concepts**
- **Day 044 — Command Line Fundamentals for Data Engineers: Files, Directories, Paths, and Help Commands**
- **Day 045 — Bash Pipes and Redirection: Connecting Commands, Standard Output, and Error Handling**
- **Day 046 — Bash Variables and Shell Scripts: Reusable Commands and Safe Automation Basics**
- **Day 047 — Git Fundamentals: Repositories, Commits, Status, Logs, and Reproducible Work**
- **Day 048 — Git Branching and Merging: Feature Work, Conflicts, and Safe Collaboration**
- **Day 049 — Git Remote Workflows: Clone, Fetch, Pull, Push, and Pull Request Thinking**
- **Day 050 — Python for Data Engineers: Setup, Interpreter, Scripts, and Virtual Environments**
- **Day 051 — Python Variables and Data Types: Numbers, Strings, Booleans, None, and Type Awareness**
- **Day 052 — Python Conditions and Boolean Logic: Validation Rules and Decision-Making**
- **Day 053 — Python Loops: Iterating Through Files, Records, and Validation Results**
- **Day 054 — Python Functions and Scope: Reusable Transformations and Clear Interfaces**
- **Day 055 — Python Collections I: Lists, Tuples, Indexing, Slicing, and Record Sequences**
- **Day 056 — Python Collections II: Dictionaries, Sets, Nested Data, and Lookup Patterns**
- **Day 057 — Python Strings for Data Engineers: Cleaning, Parsing, Formatting, and Standardisation**
- **Day 058 — Python Dates and Times: Datetime Objects, Formatting, Timezones, and Comparisons**
- **Day 059 — Python Filesystem Basics: pathlib, File Paths, Directories, CSV, and JSON Introductions**
- **Day 060 — Python Reliability Basics and Basic-Phase Review: Exceptions, Modules, Packages, and Reusable Scripts**

# Phase 2 — Medium Level

**Range:** Days 061–125  
**Phase purpose:** Turn the foundations into practical ingestion, transformation, testing, modelling, analytics-engineering, orchestration, and container workflows.  
**Milestone:** Medium level starts on Day 061 and ends after Day 125.

- **Day 061 — Python File Handling Deep Dive: Text, CSV, JSON, and Context Managers**
- **Day 062 — Python Functions for Pipelines: Parameters, Return Values, Pure Logic, and Reuse**
- **Day 063 — Python Comprehensions, Sorting, and Data Transformation Patterns**
- **Day 064 — Python Iterators and Generators: Memory-Aware Record Processing**
- **Day 065 — Python Classes and Dataclasses: Data Records, Configuration, and Pipeline Components**
- **Day 066 — Python Type Hints, Docstrings, and Maintainable Data Engineering Code**
- **Day 067 — Python Logging Fundamentals: Levels, Context, and Pipeline Diagnostics**
- **Day 068 — Python Configuration Management: Environment Variables, Config Files, and Safe Defaults**
- **Day 069 — Python Error Handling for Pipelines: Clear Failures, Retries, and Recoverable Errors**
- **Day 070 — Python Testing Fundamentals with pytest: Assertions, Discovery, and Test Structure**
- **Day 071 — pytest Fixtures and Parametrization: Reusable Test Data and Multiple Scenarios**
- **Day 072 — Python Project Structure: Modules, Packages, Dependencies, and Entry Points**
- **Day 073 — HTTP and API Fundamentals: Requests, Responses, Methods, Headers, and Status Codes**
- **Day 074 — Python API Extraction: GET Requests, JSON Responses, and Schema Checks**
- **Day 075 — API Pagination: Page Numbers, Cursors, Tokens, and Complete Data Retrieval**
- **Day 076 — API Reliability: Timeouts, Retries, Backoff, Rate Limits, and Idempotency**
- **Day 077 — API Authentication and Secret Handling: Keys, Tokens, and Safe Configuration**
- **Day 078 — Python Data Validation: Required Fields, Types, Ranges, and Review Records**
- **Day 079 — Python Timestamp Normalisation: Dates, Timezones, UTC, and Event-Time Consistency**
- **Day 080 — Python Ingestion Mini-Project: API to Validated Files with Logging and Tests**
- **Day 081 — pandas Fundamentals for Data Engineers: Series, DataFrames, Indexes, and Inspection**
- **Day 082 — pandas Input and Output: CSV, JSON, Parquet, Excel, and Data-Type Control**
- **Day 083 — pandas Selection, Filtering, Sorting, and Querying DataFrames**
- **Day 084 — pandas Missing-Data Handling: Detection, Filling, Exclusion, and Review Flags**
- **Day 085 — pandas String and Date Transformations: Standardisation and Derived Columns**
- **Day 086 — pandas Merge and Join Operations: Keys, Cardinality, and Row-Multiplication Checks**
- **Day 087 — pandas GroupBy and Aggregation: Split, Apply, Combine, and Summary Validation**
- **Day 088 — pandas Reshaping: Pivot, Melt, Stack, Unstack, and Reporting Layouts**
- **Day 089 — pandas Duplicate Handling and Data-Quality Validation**
- **Day 090 — pandas Data Types and Memory Awareness: Categories, Nullable Types, and Efficient Frames**
- **Day 091 — pandas Large-File Processing: Chunking, Incremental Reads, and Memory-Safe Patterns**
- **Day 092 — pandas Pipeline Design: Reusable Functions, Method Chaining, and Clear Stages**
- **Day 093 — pandas Mini-Project: Multi-File Ingestion, Cleaning, Joining, Validation, and Export**
- **Day 094 — Relational Data Modelling Review: Entities, Relationships, Keys, and Normalisation**
- **Day 095 — Normal Forms for Data Engineers: 1NF, 2NF, 3NF, and Practical Trade-offs**
- **Day 096 — OLTP vs OLAP: Transactional Systems, Analytical Systems, and Workload Differences**
- **Day 097 — Dimensional Modelling Fundamentals: Facts, Dimensions, Measures, and Business Processes**
- **Day 098 — Declaring Grain: Defining What One Row Represents Before Building a Model**
- **Day 099 — Star Schema Design: Fact-to-Dimension Relationships and Reporting Simplicity**
- **Day 100 — Dimension Table Design: Surrogate Keys, Natural Keys, Attributes, and Conformed Dimensions**
- **Day 101 — Fact Table Design: Transaction, Periodic Snapshot, and Accumulating Snapshot Facts**
- **Day 102 — Date Dimensions and Role-Playing Dimensions for Consistent Time Analysis**
- **Day 103 — Slowly Changing Dimensions Type 1: Current-State Corrections and History Trade-offs**
- **Day 104 — Slowly Changing Dimensions Type 2: Historical Rows, Effective Dates, and Current Flags**
- **Day 105 — Slowly Changing Dimensions Type 3 and Choosing a History Strategy**
- **Day 106 — Data Marts and Semantic Reporting Layers: Consumer-Focused Models and Stable Metrics**
- **Day 107 — Data Warehouse Architecture: Staging, Core Models, Data Marts, and Reporting Outputs**
- **Day 108 — Data Lake and Object Storage Fundamentals: Zones, Paths, Objects, and Governance**
- **Day 109 — Lakehouse Fundamentals: Warehouse Reliability with Data-Lake Flexibility**
- **Day 110 — Data Layout Fundamentals: Partitioning, Folder Design, File Sizes, and the Small-File Problem**
- **Day 111 — Apache Parquet for Data Engineers: Columnar Storage, Compression, Metadata, and Pruning**
- **Day 112 — Apache Avro and Schema Evolution: Writer Schemas, Reader Schemas, and Compatibility**
- **Day 113 — Incremental Loading: Watermarks, High-Water Marks, Idempotency, and Reprocessing**
- **Day 114 — Change Data Capture Fundamentals: Snapshots, Logs, Deletes, Ordering, and Schema Changes**
- **Day 115 — Analytics Engineering and dbt Fundamentals: Projects, Models, and DAG Thinking**
- **Day 116 — dbt Models and ref: Dependency-Aware SQL Transformations**
- **Day 117 — dbt Sources and Freshness: Declaring Inputs and Monitoring Recency**
- **Day 118 — dbt Tests and Documentation: Data Quality, Descriptions, and Lineage**
- **Day 119 — dbt Materializations: Views, Tables, Incremental Models, and Selection**
- **Day 120 — dbt Snapshots and Slowly Changing Dimension Thinking**
- **Day 121 — Apache Airflow Fundamentals: DAGs, Tasks, Dependencies, and Workflow Structure**
- **Day 122 — Airflow Scheduling Basics: Logical Dates, Data Intervals, Catchup, and Backfills**
- **Day 123 — Airflow Reliability Basics: Retries, Timeouts, Idempotency, and Task States**
- **Day 124 — Docker Fundamentals for Data Engineers: Images, Containers, and Reproducible Environments**
- **Day 125 — Dockerfiles and Containerised Python Pipelines: Dependencies, Commands, and Local Runs**

# Phase 3 — Hard Level

**Range:** Days 126–200  
**Phase purpose:** Progress into production-style engineering, distributed processing, streaming, lakehouse systems, cloud platforms, governance, observability, and architecture.  
**Milestone:** Hard level starts on Day 126 and the core roadmap completes on Day 200.

- **Day 126 — Docker Compose for Data Engineering: Services, Networks, Volumes, and Local Pipeline Stacks**
- **Day 127 — Kubernetes Fundamentals for Data Engineers: Pods, Jobs, Configuration, and Workload Concepts**
- **Day 128 — CI/CD for Data Pipelines with GitHub Actions: Workflows, Jobs, Steps, Tests, and Artifacts**
- **Day 129 — Infrastructure as Code Fundamentals with Terraform: Configuration, Providers, and Plans**
- **Day 130 — Terraform State and Modules: Reuse, Change Review, and Safe Infrastructure Thinking**
- **Day 131 — Airflow Advanced Scheduling: Trigger Rules, Branching, Sensors, and Data-Aware Workflows**
- **Day 132 — Airflow TaskFlow and Communication: Operators, XComs, Params, and Dynamic Tasks**
- **Day 133 — Airflow Testing and Observability: DAG Validation, Logs, Metrics, and Failure Diagnosis**
- **Day 134 — dbt Advanced Incremental Models: Unique Keys, Strategy Selection, and Backfill Safety**
- **Day 135 — dbt Advanced Development: Macros, Packages, State, Environments, and CI Checks**
- **Day 136 — Data Quality Engineering: Accuracy, Completeness, Consistency, Timeliness, and Uniqueness**
- **Day 137 — Great Expectations Fundamentals: Expectations, Suites, Validation Results, and Checkpoints**
- **Day 138 — Data Contracts: Schemas, Ownership, Compatibility, and Producer-Consumer Agreements**
- **Day 139 — Data Lineage with OpenLineage: Datasets, Jobs, Runs, and Dependency Visibility**
- **Day 140 — Metadata Catalogues and Data Governance: Discovery, Ownership, Classification, and Stewardship**
- **Day 141 — Data Security Fundamentals: IAM, Least Privilege, Encryption, Masking, and Secrets**
- **Day 142 — Data Observability: Logs, Metrics, Traces, Freshness, Volume, and Schema Signals**
- **Day 143 — Data Reliability Targets: SLAs, SLOs, SLIs, and Freshness Commitments**
- **Day 144 — Pipeline Incident Response: Triage, Reruns, Backfills, Recovery, and Post-Incident Learning**
- **Day 145 — Data Pipeline Testing Strategy: Unit, Integration, Contract, End-to-End, and Regression Tests**
- **Day 146 — Apache Spark Architecture: Drivers, Executors, Clusters, Jobs, Stages, and Tasks**
- **Day 147 — PySpark DataFrame Fundamentals: SparkSession, Columns, Rows, and Transformations**
- **Day 148 — PySpark Schemas and Data Types: Explicit Schemas, Nullability, and Safe Ingestion**
- **Day 149 — Spark Transformations, Actions, and Lazy Evaluation**
- **Day 150 — PySpark Data Cleaning: Nulls, Strings, Dates, Nested Data, and Derived Columns**
- **Day 151 — Spark Joins, Aggregations, and Window Functions at Distributed Scale**
- **Day 152 — Spark Partitions, Shuffles, and Data Skew: Understanding Distributed Data Movement**
- **Day 153 — Spark Caching and Persistence: Reuse, Memory Trade-offs, and When Not to Cache**
- **Day 154 — Spark File I/O: Parquet, JSON, CSV, Partition Discovery, and Partition Pruning**
- **Day 155 — Spark SQL and Query Plans: explain, Predicate Pushdown, and Optimisation Awareness**
- **Day 156 — PySpark Testing and Debugging: Small Data, Schema Assertions, and Deterministic Results**
- **Day 157 — Spark Batch Pipeline Design: Read, Validate, Transform, Reconcile, and Write Concepts**
- **Day 158 — Spark Batch Capstone: Distributed Ingestion, Cleaning, Enrichment, and Reporting**
- **Day 159 — Streaming Data Fundamentals: Events, Logs, Event Time, Processing Time, and Latency**
- **Day 160 — Apache Kafka Architecture: Brokers, Topics, Partitions, Replication, and Leaders**
- **Day 161 — Kafka Producers: Keys, Partitioning, Acknowledgements, Batching, and Idempotence**
- **Day 162 — Kafka Consumers: Polling, Consumer Groups, Partition Assignment, and Scaling**
- **Day 163 — Kafka Offsets and Delivery Semantics: At-Most-Once, At-Least-Once, and Exactly-Once Thinking**
- **Day 164 — Kafka Data Modelling: Event Keys, Topic Design, Ordering, Retention, and Compaction**
- **Day 165 — Streaming Schemas: JSON, Avro, Protobuf, Compatibility, and Schema Evolution**
- **Day 166 — Kafka Connect: Source Connectors, Sink Connectors, Tasks, and Offset Management**
- **Day 167 — Kafka Streams Fundamentals: Stateless, Stateful, and Windowed Processing Concepts**
- **Day 168 — Spark Structured Streaming: Streaming DataFrames, Sources, Sinks, and Micro-Batches**
- **Day 169 — Event-Time Windows and Watermarks: Late Data, Completeness, and Bounded State**
- **Day 170 — Stateful Streaming and Checkpoints: Recovery, Progress, State Stores, and Output Modes**
- **Day 171 — Streaming Joins and Deduplication: Keys, State, Watermarks, and Late Events**
- **Day 172 — Change Data Capture with Debezium: Snapshots, Offsets, Schema History, and Change Events**
- **Day 173 — Lakehouse Table Formats: Metadata, Transactions, Snapshots, and Engine Interoperability**
- **Day 174 — Delta Lake Fundamentals: ACID Transactions, Schema Enforcement, and Time Travel**
- **Day 175 — Delta Lake Medallion Architecture: Bronze, Silver, Gold, and Data-Quality Progression**
- **Day 176 — Apache Iceberg Fundamentals: Snapshots, Hidden Partitioning, and Table Metadata**
- **Day 177 — Iceberg Schema and Partition Evolution: Safe Changes Without Rewriting Every Query**
- **Day 178 — Apache Hudi Fundamentals: Upserts, Incremental Processing, and Table Services**
- **Day 179 — Open Table Format Comparison: Delta Lake, Apache Iceberg, and Apache Hudi**
- **Day 180 — Lakehouse Maintenance: Compaction, Small Files, Retention, Vacuum, and Snapshot Cleanup**
- **Day 181 — Catalogues and Metastores: Table Discovery, Namespaces, Governance, and Engine Access**
- **Day 182 — Databricks Data Engineering: Lakeflow, Delta Tables, Workflows, and Unity Catalog**
- **Day 183 — Multi-Cloud Data Engineering Map: Storage, Warehouses, Processing, Streaming, and Orchestration**
- **Day 184 — Google Cloud Storage and BigQuery: Data Lake and Serverless Warehouse Foundations**
- **Day 185 — BigQuery Table Design: Partitioning, Clustering, Nested Data, and Cost-Aware Queries**
- **Day 186 — Google Cloud Streaming: Pub/Sub, Dataflow, Event Time, and Delivery Semantics**
- **Day 187 — Google Cloud Batch and Orchestration: Dataproc, Cloud Composer, Dataform, and Monitoring**
- **Day 188 — AWS Data Lake Foundations: Amazon S3, AWS Glue Data Catalog, Crawlers, and ETL**
- **Day 189 — Amazon Redshift: Architecture, Distribution Styles, Sort Keys, and Workload Thinking**
- **Day 190 — AWS Distributed and Streaming Data: EMR, Kinesis, Lambda, and CloudWatch**
- **Day 191 — Azure Data Lake and Integration: ADLS Gen2, Data Factory or Fabric Pipelines, and Linked Services**
- **Day 192 — Azure Analytics and Streaming: Synapse, Azure Databricks, Event Hubs, and Azure Monitor**
- **Day 193 — Snowflake Architecture: Storage, Virtual Warehouses, Micro-Partitions, and Compute Separation**
- **Day 194 — Snowflake Data Pipelines: Streams, Tasks, Dynamic Tables, and Change Processing**
- **Day 195 — NoSQL for Data Engineers: MongoDB, DynamoDB, Cassandra, and Access-Pattern Modelling**
- **Day 196 — Distributed Data Systems Review: Consistency, Partitioning, Replication, Fault Tolerance, and Trade-offs**
- **Day 197 — Advanced Batch Pipeline Capstone: Ingestion, Validation, Transformation, Orchestration, and Reporting**
- **Day 198 — Advanced Streaming Pipeline Capstone: Kafka, CDC, Event-Time Processing, and Recovery**
- **Day 199 — Multi-Cloud Data Platform Design: Service Selection, Security, Cost, Governance, and Observability**
- **Day 200 — Final Data Engineering System Design and Portfolio Review: From Source to Trusted Data Product**

# What Learners Should Be Able to Do by Day 200

A learner who follows the complete roadmap should be able to:

- write readable, validated SQL for cleaning, joining, aggregating, modelling, and reporting
- use Python and pandas for ingestion, transformation, validation, and automation
- work with APIs, files, schemas, timestamps, logs, configuration, and tests
- design relational and dimensional data models
- understand warehouses, data lakes, lakehouses, Parquet, Avro, incremental loading, and CDC
- build analytics-engineering workflows with dbt
- design and reason about Airflow DAGs
- use Docker and understand Kubernetes, CI/CD, and Terraform concepts
- apply data-quality, lineage, governance, security, observability, and reliability practices
- build and reason about Spark and PySpark batch pipelines
- understand Kafka, Structured Streaming, event time, watermarks, state, and streaming recovery
- compare Delta Lake, Apache Iceberg, and Apache Hudi
- understand the major Data Engineering services across GCP, AWS, Azure, Databricks, Snowflake, and NoSQL platforms
- design batch, streaming, and multi-cloud data platforms
- explain an end-to-end Data Engineering system from source to trusted data product

## Is Day 200 the Final Limit?

Day 200 is the completion point for the **core curriculum**.

The Data Engineering ecosystem is too broad and changes too frequently for one fixed roadmap to include every service, database, framework, or cloud feature. Instead of extending the core roadmap indefinitely, future content can be organised into optional specialist tracks, such as:

- Advanced Google Cloud Data Engineering
- Advanced AWS Data Engineering
- Advanced Azure and Microsoft Fabric Data Engineering
- Databricks and Lakehouse Engineering
- Snowflake Engineering
- Advanced Kafka and Streaming
- Advanced Spark Performance Engineering
- Data Platform Security and Governance
- Data Reliability, Observability, and FinOps
- Certification and Interview Preparation

## Publishing Note

The roadmap represents the planned learning sequence. Individual titles or platform names may be refined when official documentation changes, but the difficulty progression and major subject areas will remain consistent.

New learning days are planned approximately five times per week.

## Repository Navigation

As each day is published, its roadmap entry can be linked to the corresponding day folder in the repository.

Suggested repository location for this file:

```text
roadmap/data-engineering-200-day-roadmap.md
```

Suggested root README link:

```markdown
## 200-Day Data Engineering Roadmap

[View the complete public roadmap](roadmap/data-engineering-200-day-roadmap.md)
```

---

**Core curriculum target:** Day 200  
**Current completed milestone:** Day 032  
**Next planned lesson:** Day 033
