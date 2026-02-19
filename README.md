## BigQuery - Base Node Types Advanced Deploy – Brief Summary

- **Fact nodes**  
  Represent measurable business events such as sales, transactions, or usage. These are the core tables used for reporting, KPIs, and trend analysis.

- **Dimension nodes**  
  Provide business context for facts, like customer, product, time, or location. They help slice and analyze facts in meaningful ways.

- **Factless fact nodes**  
  Capture business events that do not have numeric measures, such as attendance, eligibility, or process milestones. Useful for compliance, tracking, and operational analysis.

- **Persistent nodes**  
  Store curated, reusable data that remains stable over time. They act as trusted reference layers, reduce reprocessing, and ensure consistency across reports and teams.

- **Work nodes**  
  Temporary or intermediate processing layers used during transformations. They support complex logic and performance optimization but are not intended for direct business consumption.

**Summary:**  
Together, these node types ensure data is accurate, reusable, scalable, and aligned with business reporting and decision-making needs.

----

## Prerequisites Checklist

Before the application can connect, ensure the following are in place:

- **API Enabled**
  - The BigQuery API is enabled in the Google Cloud Console.

- **Service Account Key**
  - A `.json` key file has been generated for the Service Account.
  - The key file path is correctly provided to the application.

- **IAM Permissions**

  - **roles/bigquery.jobUser** (Project level)
    - Allows the service account to run query jobs and pay for compute resources within the project.

  - **roles/bigquery.dataEditor** (Dataset level)
    - Granted only on the required dataset to limit access.
    - Provides permissions to read, create, and alter data within that dataset.
  
-----

## Nodetypes Config Matrix

| Category | Feature                         | Dim | Fact | Factless | Work | PStage |
|----------|----------------------------------|-----|------|----------|------|--------|
| Create   | Create As Table                  | ✅  | ✅   | ✅       | ✅   | ✅     |
| Create   | Create As View                   | ✅  | ✅   | ⬜       | ✅   | ⬜     |
| Create   | Primary Key                      | ✅  | ✅   | ✅       | ✅   | ✅     |
| Create   | Enable Partitioning              | ✅  | ✅   | ✅       | ✅   | ✅     |
| Create   | Enable Clustering                | ✅  | ✅   | ✅       | ✅   | ✅     |
| Create   | Table Expiration                 | ✅  | ✅   | ✅       | ✅   | ✅     |
| Create   | Default Rounding Mode (Optional) | ✅  | ✅   | ✅       | ✅   | ✅     |
| Create   | Labels                           | ⬜  | ⬜   | ⬜       | ⬜   | ⬜     |
| Load     | MultiSource                      | ✅  | ✅   | ✅       | ✅   | ✅     |
| Load     | Update Strategy                  | ✅  | ⬜   | ⬜       | ⬜   | ⬜     |
| Load     | Unmatched Record Strategy        | ✅  | ✅   | ⬜       | ⬜   | ⬜     |
| Load     | Business Key                     | ✅  | ✅   | ⬜       | ⬜   | ✅     |
| Load     | Last Modified Comparison         | ✅  | ✅   | ⬜       | ⬜   | ✅     |
| Load     | Change Tracking                  | ✅  | ⬜   | ⬜       | ⬜   | ✅     |
| Load     | Exclude Columns from Merge       | ✅  | ✅   | ⬜       | ⬜   | ✅     |
| Load     | Truncate Before                  | ✅  | ✅   | ✅       | ✅   | ✅     |
| Load     | Distinct                         | ✅  | ✅   | ✅       | ✅   | ✅     |
| Load     | Group By All                     | ✅  | ✅   | ✅       | ✅   | ✅     |
| Load     | Insert Zero Key Record           | ✅  | ⬜   | ⬜       | ⬜   | ⬜     |
| Load     | Methods                          | MERGE<br/>INSERT/UPDATE | MERGE<br/>INSERT | MERGE |INSERT | MERGE<br/>INSERT |
| Others   | Enable Tests                     | ✅  | ✅   | ✅       | ✅   | ✅     |
| Others   | Pre-SQL                          | ✅  | ✅   | ✅       | ✅   | ✅     |
| Others   | Post-SQL                         | ✅  | ✅   | ✅       | ✅   | ✅     |

---

## Base Node Types Advanced Deploy

The Coalesce Base Node Types Package includes:

* [Work Advanced Deploy](#work-advanced-deploy)
* [Persistent Stage Advanced Deploy](#persistent-stage-advanced-deploy)
* [Dimension Advanced Deploy](#dimension-advanced-deploy)
* [Fact Advanced Deploy](#fact-advanced-deploy)
* [Factless Fact Advanced Deploy](#factless-fact-advanced-deploy)
* [Code](#code)

---

## Work Advanced Deploy
The Coalesce Work Node is a versatile node that allows you to develop and deploy a Work table/view in Google BigQuery.

A Work node serves as an intermediary object and is commonly employed to store raw data before undergoing the crucial phases of transformation and loading into the main tables of the data warehouse.

This pivotal step ensures that the raw data is processed and structured effectively.

### Work Advance Deploy Node Configuration
* Node Properties
* Create Options
* Load Work Options
* Other Options

<img width="476" height="288" alt="image" src="https://github.com/user-attachments/assets/c073d336-35e1-49ca-9700-7041745ffc94" />

#### Work Advanced Deploy Node Properties

| **Setting** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the work will be created |
| **Node Type** | Name of template used to create node objects |
| **Deploy Enabled** | If TRUE the node will be deployed / redeployed when changes are detected<br/> If FALSE the node will not be deployed or will be dropped during redeployment |

#### Work Advanced Deploy Options

You can create the node as:

* [Table](#work-advanced-deploy-create-as-table)
* [View](#work-advanced-deploy-create-as-view)

#### Work Advanced Deploy Create as Table

##### Work Advanced Deploy Create Options

<img width="466" height="545" alt="image" src="https://github.com/user-attachments/assets/7cdf546b-743d-4b9d-b5a2-ca32343098c8" />

| **Setting** | **Description** |
|---------|-------------|
| **Primary Key** | Toggle: True/False <br/> Define primary key columns for documentation/metadata (Not enforced). <br/>For more info please refrer [documentation](https://docs.cloud.google.com/bigquery/docs/primary-foreign-keys#limitations) |
| **Enable Partitioning** | Toggle: True/False <br/> **True**: Enables partitioning based on **Ingestion Time**, **Time-Unit Column**, or **Integer Range**.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/partitioned-tables#limitations). <br/> *Note: Changing partitions drops and recreates the table.* |
| **Partition By** | **Dropdown**: Select the partitioning strategy. <br/>- **Ingestion Time**: Partitioning based on when data is loaded. <br/>- **Time-Unit Column**: Partitioning based on a specific DATE/TIMESTAMP column or expression. <br/>- **Integer Range**: Partitioning based on numeric ranges. |
| **Partition By Column** | **Column Selector**: Choose a specific column (DataType: DATE) to use for partitioning. <br/>*Used with "Time-Unit Column" strategy.* |
| **Time-Unit Expression** | **Text Box**: Provide a SQL expression for time partitioning. <br/>*Example*: `DATE_TRUNC(columnName, MONTH)` |
| **Integer Range Expression** | **Text Box**: Provide a SQL expression for integer range partitioning. <br/>*Example*: `RANGE_BUCKET(columnName, GENERATE_ARRAY(1, 100, 200))` |
| **Ingestion-time Expression** | **Text Box**: (Optional) Provide a custom expression for ingestion-time partitioning. <br/>*Example*: `DATE_TRUNC(_PARTITIONTIME, MONTH)` |
| **Partition Expiration Days** | **Text Box**: (Optional) Specify the number of days after which a partition should expire and be deleted. <br/>*Example*: `30` |
| **Enable Clustering** | **Toggle**: True/False <br/> Enables or disables clustering for the table.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/clustered-tables#limitations) |
| **Cluster By** | **Tabular Input**: Select up to **4 columns** to cluster the table data. The order of columns determines the sort hierarchy. |
| **Table Expiration** | **Toggle**: True/False <br/> Enables or disables the automatic expiration of the table. |
| **Expiration Type** | **Dropdown**: Select how the expiration is calculated. <br/>- **EXACT DATE/DATETIME**: The table will expire at a specific point in time. <br/>- **DAYS FROM NOW**: The table will expire after a set number of days from the deployment date. |
| **Expiration Value** | **Text Box**: Enter the value based on the selected Expiration Type. <br/>- For **EXACT DATE/DATETIME**, use format: `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS` (e.g., `2024-12-31`). <br/>- For **DAYS FROM NOW**, enter an integer (e.g., `30`). |
| **Default Rounding Mode** | **Dropdown**: (Optional) Specify the rounding behavior for numeric calculations. <br/>- `ROUND_HALF_AWAY_FROM_ZERO` <br/>- `ROUND_HALF_EVEN` |

##### Work Advanced Deploy Load Options

<img width="431" height="339" alt="image" src="https://github.com/user-attachments/assets/765abfb1-fad3-45aa-9aed-2e30fcf3c81d" />

| **Setting** | **Description** |
|---------|-------------|
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Truncate Before** | Toggle: True/False<br/>**True**: Table is truncated before every load.<br/>**False**: Incremental load based on update strategy. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |

##### Work Advanced Deploy Other Options

<img width="457" height="434" alt="image" src="https://github.com/user-attachments/assets/95792ce3-8a4e-4657-a41d-9c3aafdbb7ab" />

| **Setting** | **Description** |
|---------|-------------|
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |
| **Pre-SQL / Post-SQL**| SQL to execute before or after the work load operation. |

<img width="585" height="550" alt="image" src="https://github.com/user-attachments/assets/35f3290e-52f1-4669-b758-778a1bb65dfe" />

> [!WARNING]
> **Destructive Change:** Modifying partitioning settings on a deployed table will cause the table to be **dropped and recreated** during the next deployment.<br/>

> [!WARNING]
> **Destructive Change:** Similar to partitioning, modifying clustering columns on an existing table will cause the table to be **dropped and recreated**.

##### Work Advanced Deploy Create as View

| **Setting** | **Description** |
|---------|-------------|
| **Override SQL** | Toggle: True/False <br/> Allows providing a custom SQL definition for the view. |
| **Multi Source** | Toggle: True/False<br/>**True**: Combines multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |

### Work Advanced Deploy Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

> 📘 **Specify Group by Clauses**
>
> Best Practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### Work Advanced Deploy Deployment

#### Work Advanced Deploy Initial Deployment

When deployed for the first time into an environment the Work node of materialization type table or view will execute the following stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Work Table** | This will execute a CREATE OR REPLACE statement and create a table in the target environment |
| **Create Work View** | This will execute a CREATE OR REPLACE statement and create a view in the target environment |

#### Work Advanced Deploy Redeployment

Once a Work table is initially deployed, subsequent configuration changes will result in either an in-place **`ALTER`** or a full **`DROP and RECREATE`** of the table, depending on the nature of the update (e.g., destructive changes like partitioning or clustering will trigger a recreation).

#### Altering the Work Tables

The following types of column or table modifications will result in an **`ALTER`** statement to update the table structure in the target environment, whether these changes are made individually or in combination:

*   **Primary Key Updates:** Adding/Updating/Modifying non-enforced primary key constraints.
*   **Table Metadata:** Rename or updating descriptions.
*   **Column Structure Changes:** 
    *   Adding new columns.
    *   Dropping existing columns.
    *   Renaming columns.
*   **Column Attribute Modifications:** Changing descriptions, data types or adjusting nullability constraints (e.g., `NULL` to `NOT NULL`).
*   **Configuration & Option Changes:**
    *   Updating **Table Expiration** or **Partition Expiration** settings.
    *   Adjusting the **Default Rounding Mode**.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **ALTER TABLE** | Alter table statement is executed to perform the alter operation |

#### Recreating the Work Views

The subsequent deployment of Work node of materialization type view with changes in view definition, adding table description or renaming view results in recreating the work view.

#### Drop and Recreate Work View/Table

| **Change** | **Stages Executed** |
|------------|-------------------|
| **Any materialization to Table** |  1. Drop `materialization`<br/>2. Create Work table |
| **Any materialization to View** |  1. Drop `materialization`<br/>2. Create Work view |

### Work Advanced Deploy Undeployment

If a Work Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Work Table in the target environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Drop table/view** | Removes the table or view from the environment |

-----

## Persistent Stage Advanced Deploy

The Coalesce Persistent Stage Nodes element, serving as an intermediary object, is frequently utilized to maintain data persistence across multiple execution cycles.

It plays a crucial role in tracking the historical changes of columns linked to business keys.

This functionality is particularly beneficial when the objective is to retain raw data for prolonged durations.

### Persistent Stage Advanced Deploy Node Configuration

The Persistent Stage node type has four configuration groups:

* Node Properties
* Create Options
* Load Persistent Stage Options
* Other Options

<img width="416" height="298" alt="image" src="https://github.com/user-attachments/assets/a61eab12-e8dd-46ef-befc-b5ccbe38d639" />

#### Persistent Stage Advanced Deploy Node Properties

| **Setting** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the persistent stage will be created |
| **Node Type** | Name of template used to create node objects |
| **Deploy Enabled** | If TRUE the node will be deployed / redeployed when changes are detected<br/> If FALSE the node will not be deployed or will be dropped during redeployment |

#### Persistent Stage Advanced Deploy Options

You can create the node as:

* [Table](#persistent-advanced-deploy-create-as-table)

#### Persistent Stage Advanced Deploy Create as Table

##### Persistent Stage Advance Deploy Create Options
<img width="362" height="526" alt="image" src="https://github.com/user-attachments/assets/e52eb6a4-9c77-4157-b8c1-643f82a8d8bf" />

| **Setting** | **Description** |
|---------|-------------|
| **Primary Key** | Toggle: True/False <br/> Define primary key columns for documentation/metadata (Not enforced). <br/>For more info please refrer [documentation](https://docs.cloud.google.com/bigquery/docs/primary-foreign-keys#limitations) |
| **Enable Partitioning** | Toggle: True/False <br/> **True**: Enables partitioning based on **Ingestion Time**, **Time-Unit Column**, or **Integer Range**.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/partitioned-tables#limitations). <br/> *Note: Changing partitions drops and recreates the table.* |
| **Partition By** | **Dropdown**: Select the partitioning strategy. <br/>- **Ingestion Time**: Partitioning based on when data is loaded. <br/>- **Time-Unit Column**: Partitioning based on a specific DATE/TIMESTAMP column or expression. <br/>- **Integer Range**: Partitioning based on numeric ranges. |
| **Partition By Column** | **Column Selector**: Choose a specific column (DataType: DATE) to use for partitioning. <br/>*Used with "Time-Unit Column" strategy.* |
| **Time-Unit Expression** | **Text Box**: Provide a SQL expression for time partitioning. <br/>*Example*: `DATE_TRUNC(columnName, MONTH)` |
| **Integer Range Expression** | **Text Box**: Provide a SQL expression for integer range partitioning. <br/>*Example*: `RANGE_BUCKET(columnName, GENERATE_ARRAY(1, 100, 200))` |
| **Ingestion-time Expression** | **Text Box**: (Optional) Provide a custom expression for ingestion-time partitioning. <br/>*Example*: `DATE_TRUNC(_PARTITIONTIME, MONTH)` |
| **Partition Expiration Days** | **Text Box**: (Optional) Specify the number of days after which a partition should expire and be deleted. <br/>*Example*: `30` |
| **Enable Clustering** | **Toggle**: True/False <br/> Enables or disables clustering for the table.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/clustered-tables#limitations) |
| **Cluster By** | **Tabular Input**: Select up to **4 columns** to cluster the table data. The order of columns determines the sort hierarchy. |
| **Table Expiration** | **Toggle**: True/False <br/> Enables or disables the automatic expiration of the table. |
| **Expiration Type** | **Dropdown**: Select how the expiration is calculated. <br/>- **EXACT DATE/DATETIME**: The table will expire at a specific point in time. <br/>- **DAYS FROM NOW**: The table will expire after a set number of days from the deployment date. |
| **Expiration Value** | **Text Box**: Enter the value based on the selected Expiration Type. <br/>- For **EXACT DATE/DATETIME**, use format: `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS` (e.g., `2024-12-31`). <br/>- For **DAYS FROM NOW**, enter an integer (e.g., `30`). |
| **Default Rounding Mode** | **Dropdown**: (Optional) Specify the rounding behavior for numeric calculations. <br/>- `ROUND_HALF_AWAY_FROM_ZERO` <br/>- `ROUND_HALF_EVEN` |

##### Persistent Stage Advance Deploy Load Options

<img width="507" height="762" alt="image" src="https://github.com/user-attachments/assets/cd5fbedf-5186-446c-8b81-79f6a851a565" />


| **Setting** | **Description** |
|---------|-------------|
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Business key** | Required column for SCD Dimensions.<br/>**Note:** Geometry and Geography data type columns are not supported as business key columns. |
| **Last Modified Comparison**<br/> | **Toggle**: True/False <br/>- **True**: Enables high-performance Change Data Capture (CDC) by comparing a specific source timestamp or numeric column to identify records that have changed since the last load. <br/>- **False**: Performs standard CDC by comparing data values across all designated Change Tracking columns to detect modifications. |
| **Treat NULL as Current Timestamp**(For TIMESTAMP Columns) | **Toggle**: True/False <br/>- **True**: Source records with a `NULL` value in the comparison column are assigned the current system timestamp. This ensures that records with missing modification metadata are treated as "new" and are updated in the target table. <br/>- **False**: `NULL` values are handled per standard SQL comparison rules, which may result in these records being ignored during incremental loads. |
| **Enable SCD Type 2** | Toggle: True/False <br/> **True**: Maintains historical versions of records using system start/end dates and version flags. |
| **Change Tracking Columns**<br/>(Visible when Last Modified Comparison is OFF) | **Checkbox List**: Provides a list of available target columns to define historical tracking behavior. <br/>- **SCD Type 2 (History):** Any column selected in this list will trigger the creation of a new record version when a change is detected. <br/>- **SCD Type 1 (Overwrite):** Columns that are **not** selected will follow SCD Type 1 logic, meaning changes to these columns will overwrite the existing current record without creating a new version. <br/>- **Default Logic:** If **no columns** are selected, the entire table is treated as **SCD Type 1**. |
| **Exclude Columns from Merge** | **Toggle**: True/False <br/> Enables the ability to exclude specific columns from the `UPDATE` clause of the **`MERGE INTO`** statement. This is primarily used in **SCD Type 1** scenarios to ensure that certain columns remain unchanged after the initial record creation. <br/> *Note: This option is only available when no Change Tracking columns are selected and Last Modified Comparison is disabled.* |
| **Exclude Merge List** | **Tabular Input**: A list of columns to be omitted from the update logic. <br/>- **Exclude Column Name**: Select the specific column(s) that should be ignored during the update phase of the merge. These columns will be populated during the initial **INSERT** but never modified during a **MERGE UPDATE**. |
| **Truncate Before** | Toggle: True/False<br/>**True**: Table is truncated before every load.<br/>**False**: Incremental load based on update strategy. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |

##### Persistent Stage Advance Deploy Other Options

<img width="468" height="402" alt="image" src="https://github.com/user-attachments/assets/b1abdda7-6c2f-423c-a12a-ff57ec2d6e2d" />


| **Setting** | **Description** |
|---------|-------------|
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |
| **Pre-SQL / Post-SQL**| SQL to execute before or after the persistent stage load operation. |

<img width="585" height="550" alt="image" src="https://github.com/user-attachments/assets/35f3290e-52f1-4669-b758-778a1bb65dfe" />

> [!WARNING]
> **Destructive Change:** Modifying partitioning settings on a deployed table will cause the table to be **dropped and recreated** during the next deployment.<br/>

> [!WARNING]
> **Destructive Change:** Similar to partitioning, modifying clustering columns on an existing table will cause the table to be **dropped and recreated**.


#### Persistent Stage Advanced Deploy System Columns

These columns are automatically added to manage dimension logic:

| **Column** | **Description** |
|----------|-------------|
| **`{{NODE_NAME}}`_key** | The generated Surrogate Key for the dimension record. |
| **system_version** | Incremental version number for SCD Type 2 tracking. |
| **system_current_flag** | Indicates the active record ('Y'/'N'). |
| **system_start_date** | The timestamp when the record version became active. |
| **system_end_date** | The timestamp when the record version was superseded (Default: 2999-12-31). |
| **system_create_date** | Audit timestamp for when the row was first inserted. |
| **system_update_date** | Audit timestamp for the last modification. |

## BigQuery SCD Implementation Preferences

* **Strategy Selection:** Use the **MERGE** statement for creating Slowly Changing Dimensions (SCD Type 1 or 2).
* **Performance:** While traditional **INSERT/UPDATE** DML can be used for smaller batches, **MERGE** is recommended for superior execution performance on large datasets.
* **Optimization:** For tables exceeding **10 million rows**, ensure the table is **partitioned** and **clustered** to minimize the bytes scanned during the MERGE operation.

### Persistent Stage Advanced Deploy Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

> 📘 **Specify Group by Clauses**
>
> Best Practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### Persistent Stage Advanced Deploy Deployment

When deployed for the first time into an environment the persistent stage node of materialization type table or view will execute the following stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Persistent Table** | This will execute a CREATE OR REPLACE statement and create a table in the target environment |


#### Persistent Stage Advanced Deploy Redeployment

Once a Persistent Stage table is initially deployed, subsequent configuration changes will result in either an in-place **`ALTER`** or a full **`DROP and RECREATE`** of the table, depending on the nature of the update (e.g., destructive changes like partitioning or clustering will trigger a recreation).

#### Altering the Persistent Stage Tables

The following types of column or table modifications will result in an **`ALTER`** statement to update the table structure in the target environment, whether these changes are made individually or in combination:

*   **Primary Key Updates:** Adding/Updating/Modifying non-enforced primary key constraints.
*   **Table Metadata:** Rename or updating descriptions.
*   **Column Structure Changes:** 
    *   Adding new columns.
    *   Dropping existing columns.
    *   Renaming columns.
*   **Column Attribute Modifications:** Changing descriptions, data types or adjusting nullability constraints (e.g., `NULL` to `NOT NULL`).
*   **Configuration & Option Changes:**
    *   Updating **Table Expiration** or **Partition Expiration** settings.
    *   Adjusting the **Default Rounding Mode**.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **ALTER TABLE** | Alter table statement is executed to perform the alter operation |

#### Drop and Recreate Persistent Stage Table

| **Change** | **Stages Executed** |
|------------|-------------------|
| **Any materialization to Table** |  1. Drop `materialization`<br/>2. Create Persistent table |

### Persistent Stage Advanced Deploy Undeployment

If a Persistent Stage Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Persistent Table in the target environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Drop table** | Removes the table from the environment |

-----

## Dimension Advanced Deploy

The Coalesce Dimension Advanced Deploy node is designed to manage the lifecycle of dimension tables, supporting both Slowly Changing Dimensions (SCD) Type 1 and Type 2. It provides advanced controls for partitioning, clustering, and automated "Zero Key" (Unknown member) record injection.

This node ensures historical integrity through system-managed versioning columns while offering flexible loading strategies like MERGE and INSERT/UPDATE.

### Dimension Advanced Deploy Node Configuration

The Dimension node type has four configuration groups:

* Node Properties
* Create Options
* Load Dimension Options
* Zero Key Record Options
* Other Options

<img width="623" height="263" alt="image" src="https://github.com/user-attachments/assets/06b9392f-0ef6-48a2-a8c7-5a03696c6883" />

#### Dimension Advanced Deploy Node Properties

| **Setting** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Dimension will be created |
| **Node Type** | Name of template used to create node objects |
| **Deploy Enabled** | If TRUE the node will be deployed / redeployed when changes are detected<br/> If FALSE the node will not be deployed or will be dropped during redeployment |

#### Dimension Advanced Deploy Options

You can create the node as:

* [Table](#dimension-advanced-deploy-create-as-table)
* [View](#dimension-advanced-deploy-create-as-view)

#### Dimension Advanced Deploy Create as Table

<img width="683" height="518" alt="image" src="https://github.com/user-attachments/assets/1dff2e17-31dd-4023-97f0-9e9047aeb0a3" />

#### Dimension Advanced Deploy Create Options

| **Setting** | **Description** |
|---------|-------------|
| **Primary Key** | Toggle: True/False <br/> Define primary key columns for documentation/metadata (Not enforced). <br/>For more info please refrer [documentation](https://docs.cloud.google.com/bigquery/docs/primary-foreign-keys#limitations) |
| **Enable Partitioning** | Toggle: True/False <br/> **True**: Enables partitioning based on **Ingestion Time**, **Time-Unit Column**, or **Integer Range**.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/partitioned-tables#limitations). <br/> *Note: Changing partitions drops and recreates the table.* |
| **Partition By** | **Dropdown**: Select the partitioning strategy. <br/>- **Ingestion Time**: Partitioning based on when data is loaded. <br/>- **Time-Unit Column**: Partitioning based on a specific DATE/TIMESTAMP column or expression. <br/>- **Integer Range**: Partitioning based on numeric ranges. |
| **Partition By Column** | **Column Selector**: Choose a specific column (DataType: DATE) to use for partitioning. <br/>*Used with "Time-Unit Column" strategy.* |
| **Time-Unit Expression** | **Text Box**: Provide a SQL expression for time partitioning. <br/>*Example*: `DATE_TRUNC(columnName, MONTH)` |
| **Integer Range Expression** | **Text Box**: Provide a SQL expression for integer range partitioning. <br/>*Example*: `RANGE_BUCKET(columnName, GENERATE_ARRAY(1, 100, 200))` |
| **Ingestion-time Expression** | **Text Box**: (Optional) Provide a custom expression for ingestion-time partitioning. <br/>*Example*: `DATE_TRUNC(_PARTITIONTIME, MONTH)` |
| **Partition Expiration Days** | **Text Box**: (Optional) Specify the number of days after which a partition should expire and be deleted. <br/>*Example*: `30` |
| **Enable Clustering** | **Toggle**: True/False <br/> Enables or disables clustering for the table.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/clustered-tables#limitations) |
| **Cluster By** | **Tabular Input**: Select up to **4 columns** to cluster the table data. The order of columns determines the sort hierarchy. |
| **Table Expiration** | **Toggle**: True/False <br/> Enables or disables the automatic expiration of the table. |
| **Expiration Type** | **Dropdown**: Select how the expiration is calculated. <br/>- **EXACT DATE/DATETIME**: The table will expire at a specific point in time. <br/>- **DAYS FROM NOW**: The table will expire after a set number of days from the deployment date. |
| **Expiration Value** | **Text Box**: Enter the value based on the selected Expiration Type. <br/>- For **EXACT DATE/DATETIME**, use format: `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS` (e.g., `2024-12-31`). <br/>- For **DAYS FROM NOW**, enter an integer (e.g., `30`). |
| **Default Rounding Mode** | **Dropdown**: (Optional) Specify the rounding behavior for numeric calculations. <br/>- `ROUND_HALF_AWAY_FROM_ZERO` <br/>- `ROUND_HALF_EVEN` |

#### Dimension Advanced Deploy Load Options

| **Setting** | **Description** |
|---------|-------------|
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Update Strategy** | Choose the SQL pattern for loading data: <br/>- **MERGE**: Utilizes a single **`MERGE INTO`** statement to synchronize the source and target. <br/>- **INSERT/UPDATE**: Utilizes a multi-step transactional approach (e.g., **`BEGIN TRANSACTION`**...**`COMMIT`**) to execute separate update and insert operations. |
| **Unmatched Record Strategy** | Options for `NO DELETE`, `SOFT DELETE` (Flagging), or `HARD DELETE` (Physical removal) for records no longer in source. |
| **Business key** | Required column for SCD Dimensions.<br/>**Note:** Geometry and Geography data type columns are not supported as business key columns. |
| **Last Modified Comparison**<br/> | **Toggle**: True/False <br/>- **True**: Enables high-performance Change Data Capture (CDC) by comparing a specific source timestamp or numeric column to identify records that have changed since the last load. <br/>- **False**: Performs standard CDC by comparing data values across all designated Change Tracking columns to detect modifications. |
| **Treat NULL as Current Timestamp**(For TIMESTAMP Columns) | **Toggle**: True/False <br/>- **True**: Source records with a `NULL` value in the comparison column are assigned the current system timestamp. This ensures that records with missing modification metadata are treated as "new" and are updated in the target table. <br/>- **False**: `NULL` values are handled per standard SQL comparison rules, which may result in these records being ignored during incremental loads. |
| **Enable SCD Type 2** | Toggle: True/False <br/> **True**: Maintains historical versions of records using system start/end dates and version flags. |
| **Change Tracking Columns**<br/>(Visible when Last Modified Comparison is OFF) | **Checkbox List**: Provides a list of available target columns to define historical tracking behavior. <br/>- **SCD Type 2 (History):** Any column selected in this list will trigger the creation of a new record version when a change is detected. <br/>- **SCD Type 1 (Overwrite):** Columns that are **not** selected will follow SCD Type 1 logic, meaning changes to these columns will overwrite the existing current record without creating a new version. <br/>- **Default Logic:** If **no columns** are selected, the entire table is treated as **SCD Type 1**. |
| **Exclude Columns from Merge** | **Toggle**: True/False <br/> Enables the ability to exclude specific columns from the `UPDATE` clause of the **`MERGE INTO`** statement. This is primarily used in **SCD Type 1** scenarios to ensure that certain columns remain unchanged after the initial record creation. <br/> *Note: This option is only available when no Change Tracking columns are selected and Last Modified Comparison is disabled.* |
| **Exclude Merge List** | **Tabular Input**: A list of columns to be omitted from the update logic. <br/>- **Exclude Column Name**: Select the specific column(s) that should be ignored during the update phase of the merge. These columns will be populated during the initial **INSERT** but never modified during a **MERGE UPDATE**. |
| **Insert Zero Key** | Toggle: True/False <br/> Automatically inserts a placeholder record (e.g., ID 0, "UNKNOWN") to handle null foreign keys in fact tables. |
| **Default Surrogate Key Value** | The numeric or string value to be assigned to the Surrogate Key column for the zero key record. <br/>**Default**: `0` |
| **Default String Value** | The default value used for all string/text columns in the zero key record. <br/>**Default**: `UNKNOWN` |
| **Default Date Value** | The default value used for all Date columns (Format: DD-MM-YYYY). <br/>**Default**: `01-01-1900` |
| **Default Timestamp Value** | The default value used for all Timestamp columns (Format: YYYY-MM-DD HH24:MI:SS). <br/>**Default**: `1900-01-01 00:00:00` |
| **Default Boolean Value** | The default value used for all Boolean columns. <br/>**Options**: `TRUE`, `FALSE` |
| **Advanced Zero Key Record Options** | **Toggle**: True/False <br/> When enabled, allows for granular control over specific columns via the Custom Zero Key Values table. |
| **Custom Zero Key Values** | **Tabular Input**: Allows you to override the global defaults for specific columns. <br/>- **Column**: Select a specific column from the node. <br/>- **Default Value**: Provide a specific value for that column for the zero key record. |
| **Truncate Before** | Toggle: True/False<br/>**True**: Table is truncated before every load.<br/>**False**: Incremental load based on update strategy. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |

#### Dimension Advanced Deploy Other Options

| **Setting** | **Description** |
|---------|-------------|
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |
| **Pre-SQL / Post-SQL**| SQL to execute before or after the dimension load operation. |

<img width="688" height="595" alt="image" src="https://github.com/user-attachments/assets/bc2c8a47-6ea9-4fcc-bf74-c7118f0cc24b" />

> [!WARNING]
> **Destructive Change:** Modifying partitioning settings on a deployed table will cause the table to be **dropped and recreated** during the next deployment.<br/>

> [!WARNING]
> **Destructive Change:** Similar to partitioning, modifying clustering columns on an existing table will cause the table to be **dropped and recreated**.

##### Dimension Advanced Deploy Create as View

| **Setting** | **Description** |
|---------|-------------|
| **Override SQL** | Toggle: True/False <br/> Allows providing a custom SQL definition for the view. |
| **Multi Source** | Toggle: True/False<br/>**True**: Combines multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |

#### Dimension Advanced Deploy System Columns

These columns are automatically added to manage dimension logic:

| **Column** | **Description** |
|----------|-------------|
| **`{{NODE_NAME}}`_key** | The generated Surrogate Key for the dimension record. |
| **system_version** | Incremental version number for SCD Type 2 tracking. |
| **system_current_flag** | Indicates the active record ('Y'/'N'). |
| **system_start_date** | The timestamp when the record version became active. |
| **system_end_date** | The timestamp when the record version was superseded (Default: 2999-12-31). |
| **system_create_date** | Audit timestamp for when the row was first inserted. |
| **system_update_date** | Audit timestamp for the last modification. |

## BigQuery SCD Implementation Preferences

* **Strategy Selection:** Use the **MERGE** statement for creating Slowly Changing Dimensions (SCD Type 1 or 2) with NO DELETE/SOFT DELETE/HARD DELETE
* **Performance:** While traditional **INSERT/UPDATE** DML can be used for smaller batches, **MERGE** is recommended for superior execution performance on large datasets.
* **Optimization:** For tables exceeding **10 million rows**, ensure the table is **partitioned** and **clustered** to minimize the bytes scanned during the MERGE operation.

### Dimension Advanced Deploy Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

> 📘 **Specify Group by Clauses**
>
> Best Practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### Dimension Advanced Deploy Deployment

#### Dimension Advanced Deploy Initial Deployment

When deployed for the first time into an environment the Dimension node of materialization type table or view will execute the following stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Dimension Table** | This will execute a CREATE OR REPLACE statement and create a table in the target environment |
| **Create Dimension View** | This will execute a CREATE OR REPLACE statement and create a view in the target environment |

#### Dimension Advanced Deploy Redeployment

Once a Dimension table is initially deployed, subsequent configuration changes will result in either an in-place **`ALTER`** or a full **`DROP and RECREATE`** of the table, depending on the nature of the update (e.g., destructive changes like partitioning or clustering will trigger a recreation).

#### Altering the Dimension Tables

The following types of column or table modifications will result in an **`ALTER`** statement to update the table structure in the target environment, whether these changes are made individually or in combination:

*   **Primary Key Updates:** Adding/Updating/Modifying non-enforced primary key constraints.
*   **Table Metadata:** Rename or updating descriptions.
*   **Column Structure Changes:** 
    *   Adding new columns.
    *   Dropping existing columns.
    *   Renaming columns.
*   **Column Attribute Modifications:** Changing descriptions, data types or adjusting nullability constraints (e.g., `NULL` to `NOT NULL`).
*   **Configuration & Option Changes:**
    *   Updating **Table Expiration** or **Partition Expiration** settings.
    *   Adjusting the **Default Rounding Mode**.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **ALTER TABLE** | Alter table statement is executed to perform the alter operation |

#### Recreating the Dimension Views

The subsequent deployment of Dimension node of materialization type view with changes in view definition, adding table description or renaming view results in recreating the dimension view.

#### Drop and Recreate Dimension View/Table

| **Change** | **Stages Executed** |
|------------|-------------------|
| **Any materialization to Table** |  1. Drop `materialization`<br/>2. Create Dimension table |
| **Any materialization to View** |  1. Drop `materialization`<br/>2. Create Dimension view |

### Dimension Advanced Deploy Undeployment

If a Dimension Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Dimension Table in the target environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Drop table/view** | Removes the table or view from the environment |

-----

## Fact Advanced Deploy

The Coalesce Fact Advanced Deploy node is designed to manage the lifecycle of fact tables, supporting both Slowly Changing Fact (SCD) Type 1 and Type 2. It provides advanced controls for partitioning, clustering.

This node ensures historical integrity through system-managed versioning columns while offering flexible loading strategies like MERGE.

### Fact Advanced Deploy Node Configuration

The Fact node type has four configuration groups:

* Node Properties
* Create Options
* Load Fact Options
* Other Options

  <img width="706" height="274" alt="image" src="https://github.com/user-attachments/assets/bedc2d2c-5193-47b2-a99b-76f0ae308cac" />

#### Fact Advanced Deploy Node Properties

| **Setting** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Fact will be created |
| **Node Type** | Name of template used to create node objects |
| **Deploy Enabled** | If TRUE the node will be deployed / redeployed when changes are detected<br/> If FALSE the node will not be deployed or will be dropped during redeployment |

#### Fact Advanced Deploy Options

You can create the node as:

* [Table](#fact-advanced-deploy-create-as-table)
* [View](#fact-advanced-deploy-create-as-view)

#### Fact Advanced Deploy Create as Table

<img width="689" height="637" alt="image" src="https://github.com/user-attachments/assets/4aac2a97-ef31-48b7-8480-5cd41ba7d33c" />

#### Fact Advanced Deploy Create Options

| **Setting** | **Description** |
|---------|-------------|
| **Primary Key** | Toggle: True/False <br/> Define primary key columns for documentation/metadata (Not enforced). <br/>For more info please refrer [documentation](https://docs.cloud.google.com/bigquery/docs/primary-foreign-keys#limitations) |
| **Enable Partitioning** | Toggle: True/False <br/> **True**: Enables partitioning based on **Ingestion Time**, **Time-Unit Column**, or **Integer Range**.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/partitioned-tables#limitations). <br/> *Note: Changing partitions drops and recreates the table.* |
| **Partition By** | **Dropdown**: Select the partitioning strategy. <br/>- **Ingestion Time**: Partitioning based on when data is loaded. <br/>- **Time-Unit Column**: Partitioning based on a specific DATE/TIMESTAMP column or expression. <br/>- **Integer Range**: Partitioning based on numeric ranges. |
| **Partition By Column** | **Column Selector**: Choose a specific column (DataType: DATE) to use for partitioning. <br/>*Used with "Time-Unit Column" strategy.* |
| **Time-Unit Expression** | **Text Box**: Provide a SQL expression for time partitioning. <br/>*Example*: `DATE_TRUNC(columnName, MONTH)` |
| **Integer Range Expression** | **Text Box**: Provide a SQL expression for integer range partitioning. <br/>*Example*: `RANGE_BUCKET(columnName, GENERATE_ARRAY(1, 100, 200))` |
| **Ingestion-time Expression** | **Text Box**: (Optional) Provide a custom expression for ingestion-time partitioning. <br/>*Example*: `DATE_TRUNC(_PARTITIONTIME, MONTH)` |
| **Partition Expiration Days** | **Text Box**: (Optional) Specify the number of days after which a partition should expire and be deleted. <br/>*Example*: `30` |
| **Enable Clustering** | **Toggle**: True/False <br/> Enables or disables clustering for the table.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/clustered-tables#limitations) |
| **Cluster By** | **Tabular Input**: Select up to **4 columns** to cluster the table data. The order of columns determines the sort hierarchy. |
| **Table Expiration** | **Toggle**: True/False <br/> Enables or disables the automatic expiration of the table. |
| **Expiration Type** | **Dropdown**: Select how the expiration is calculated. <br/>- **EXACT DATE/DATETIME**: The table will expire at a specific point in time. <br/>- **DAYS FROM NOW**: The table will expire after a set number of days from the deployment date. |
| **Expiration Value** | **Text Box**: Enter the value based on the selected Expiration Type. <br/>- For **EXACT DATE/DATETIME**, use format: `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS` (e.g., `2024-12-31`). <br/>- For **DAYS FROM NOW**, enter an integer (e.g., `30`). |
| **Default Rounding Mode** | **Dropdown**: (Optional) Specify the rounding behavior for numeric calculations. <br/>- `ROUND_HALF_AWAY_FROM_ZERO` <br/>- `ROUND_HALF_EVEN` |

#### Fact Advanced Deploy Load Options

| **Setting** | **Description** |
|---------|-------------|
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Unmatched Record Strategy** | Options for `NO DELETE` or `HARD DELETE` (Physical removal) for records no longer in source. <br/>*Available only when atleast one Business Key is chosen*|
| **Business key** | Required column for SCD Fact.<br/>**Note:** Geometry and Geography data type columns are not supported as business key columns. |
| **Last Modified Comparison**<br/> | **Toggle**: True/False <br/>- **True**: Enables high-performance Change Data Capture (CDC) by comparing a specific source timestamp or numeric column to identify records that have changed since the last load. <br/>- **False**: Performs standard CDC by comparing data values across all designated Change Tracking columns to detect modifications.<br/>*Available only when atleast one Business Key is chosen*|
| **Treat NULL as Current Timestamp**(For TIMESTAMP Columns) | **Toggle**: True/False <br/>- **True**: Source records with a `NULL` value in the comparison column are assigned the current system timestamp. This ensures that records with missing modification metadata are treated as "new" and are updated in the target table. <br/>- **False**: `NULL` values are handled per standard SQL comparison rules, which may result in these records being ignored during incremental loads. *Available only when atleast one Business Key is chosen*|
| **Enable SCD Type 2** | Toggle: True/False <br/> **True**: Maintains historical versions of records using system start/end dates and version flags. <br/>*Available only when atleast one Business Key is chosen*|
| **Exclude Columns from Merge** | **Toggle**: True/False <br/> Enables the ability to exclude specific columns from the `UPDATE` clause of the **`MERGE INTO`** statement. This is primarily used in **SCD Type 1** scenarios to ensure that certain columns remain unchanged after the initial record creation. <br/>*Available only when atleast one Business Key is chosen*|
| **Exclude Merge List** | **Tabular Input**: A list of columns to be omitted from the update logic. <br/>- **Exclude Column Name**: Select the specific column(s) that should be ignored during the update phase of the merge. These columns will be populated during the initial **INSERT** but never modified during a **MERGE UPDATE**. <br/>*Available only when atleast one Business Key is chosen* |
| **Truncate Before** | Toggle: True/False<br/>**True**: Table is truncated before every load.<br/>**False**: Incremental load based on update strategy. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |

#### Fact Advanced Deploy Other Options

| **Setting** | **Description** |
|---------|-------------|
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |
| **Pre-SQL / Post-SQL**| SQL to execute before or after the Fact load operation. |

<img width="688" height="595" alt="image" src="https://github.com/user-attachments/assets/b179b4cf-e2bb-41cf-9875-0fbd297444ca" />

> [!WARNING]
> **Destructive Change:** Modifying partitioning settings on a deployed table will cause the table to be **dropped and recreated** during the next deployment.<br/>

> [!WARNING]
> **Destructive Change:** Similar to partitioning, modifying clustering columns on an existing table will cause the table to be **dropped and recreated**.

##### Fact Advanced Deploy Create as View

| **Setting** | **Description** |
|---------|-------------|
| **Override SQL** | Toggle: True/False <br/> Allows providing a custom SQL definition for the view. |
| **Multi Source** | Toggle: True/False<br/>**True**: Combines multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |

#### Fact Advanced Deploy System Columns

These columns are automatically added to manage fact logic:

| **Column** | **Description** |
|----------|-------------|
| **system_create_date** | Audit timestamp for when the row was first inserted. |
| **system_update_date** | Audit timestamp for the last modification. |

## BigQuery SCD Implementation Preferences

* **Optimization:** For tables exceeding **10 million rows**, ensure the table is **partitioned** and **clustered** to minimize the bytes scanned during the MERGE operation.

### Fact Advanced Deploy Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

> 📘 **Specify Group by Clauses**
>
> Best Practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### Fact Advanced Deploy Deployment

#### Fact Advanced Deploy Initial Deployment

When deployed for the first time into an environment the Fact node of materialization type table or view will execute the following stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Fact Table** | This will execute a CREATE OR REPLACE statement and create a table in the target environment |
| **Create Fact View** | This will execute a CREATE OR REPLACE statement and create a view in the target environment |

#### Fact Advanced Deploy Redeployment

Once a Fact table is initially deployed, subsequent configuration changes will result in either an in-place **`ALTER`** or a full **`DROP and RECREATE`** of the table, depending on the nature of the update (e.g., destructive changes like partitioning or clustering will trigger a recreation).

#### Altering the Fact Tables

The following types of column or table modifications will result in an **`ALTER`** statement to update the table structure in the target environment, whether these changes are made individually or in combination:

*   **Primary Key Updates:** Adding/Updating/Modifying non-enforced primary key constraints.
*   **Table Metadata:** Rename or updating descriptions.
*   **Column Structure Changes:** 
    *   Adding new columns.
    *   Dropping existing columns.
    *   Renaming columns.
*   **Column Attribute Modifications:** Changing descriptions, data types or adjusting nullability constraints (e.g., `NULL` to `NOT NULL`).
*   **Configuration & Option Changes:**
    *   Updating **Table Expiration** or **Partition Expiration** settings.
    *   Adjusting the **Default Rounding Mode**.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **ALTER TABLE** | Alter table statement is executed to perform the alter operation |

#### Recreating the Fact Views

The subsequent deployment of Fact node of materialization type view with changes in view definition, adding table description or renaming view results in recreating the Fact view.

#### Drop and Recreate Fact View/Table

| **Change** | **Stages Executed** |
|------------|-------------------|
| **Any materialization to Table** |  1. Drop `materialization`<br/>2. Create Fact table |
| **Any materialization to View** |  1. Drop `materialization`<br/>2. Create Fact view |

### Fact Advanced Deploy Undeployment

If a Fact Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Fact Table in the target environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Drop table/view** | Removes the table or view from the environment |

-----

## Factless Fact Advanced Deploy

The Coalesce Fact UDN is a versatile node that allows you to develop and deploy a Fact table in Google BigQuery.

A factless fact table is used to record events or situations that have no measures.

### Factless Fact Advanced Deploy Node Configuration

The Factless Fact node type has four configuration groups:

* Node Properties
* Create Options
* Load Fact Options
* Other Options

<img width="393" height="286" alt="image" src="https://github.com/user-attachments/assets/9eb7142c-b49c-4563-8103-920b6b83e318" />

#### Factless Fact Advanced Deploy Node Properties

| **Setting** | **Description** |
|----------|-------------|
| **Storage Location** | Storage Location where the Fact will be created |
| **Node Type** | Name of template used to create node objects |
| **Deploy Enabled** | If TRUE the node will be deployed / redeployed when changes are detected<br/> If FALSE the node will not be deployed or will be dropped during redeployment |

#### Factless Fact Advanced Deploy Options

You can create the node as:

* [Table](#fact-advanced-deploy-create-as-table)

#### Factless Fact Advanced Deploy Create as Table

##### Factless Fact Advanced Deploy Create Options

<img width="378" height="537" alt="image" src="https://github.com/user-attachments/assets/1877ebf9-0b52-4a7e-a475-5efa97e039b6" />

| **Setting** | **Description** |
|---------|-------------|
| **Primary Key** | Toggle: True/False <br/> Define primary key columns for documentation/metadata (Not enforced). <br/>For more info please refrer [documentation](https://docs.cloud.google.com/bigquery/docs/primary-foreign-keys#limitations) |
| **Enable Partitioning** | Toggle: True/False <br/> **True**: Enables partitioning based on **Ingestion Time**, **Time-Unit Column**, or **Integer Range**.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/partitioned-tables#limitations). <br/> *Note: Changing partitions drops and recreates the table.* |
| **Partition By** | **Dropdown**: Select the partitioning strategy. <br/>- **Ingestion Time**: Partitioning based on when data is loaded. <br/>- **Time-Unit Column**: Partitioning based on a specific DATE/TIMESTAMP column or expression. <br/>- **Integer Range**: Partitioning based on numeric ranges. |
| **Partition By Column** | **Column Selector**: Choose a specific column (DataType: DATE) to use for partitioning. <br/>*Used with "Time-Unit Column" strategy.* |
| **Time-Unit Expression** | **Text Box**: Provide a SQL expression for time partitioning. <br/>*Example*: `DATE_TRUNC(columnName, MONTH)` |
| **Integer Range Expression** | **Text Box**: Provide a SQL expression for integer range partitioning. <br/>*Example*: `RANGE_BUCKET(columnName, GENERATE_ARRAY(1, 100, 200))` |
| **Ingestion-time Expression** | **Text Box**: (Optional) Provide a custom expression for ingestion-time partitioning. <br/>*Example*: `DATE_TRUNC(_PARTITIONTIME, MONTH)` |
| **Partition Expiration Days** | **Text Box**: (Optional) Specify the number of days after which a partition should expire and be deleted. <br/>*Example*: `30` |
| **Enable Clustering** | **Toggle**: True/False <br/> Enables or disables clustering for the table.<br/>For more info please refer [documentation](https://docs.cloud.google.com/bigquery/docs/clustered-tables#limitations) |
| **Cluster By** | **Tabular Input**: Select up to **4 columns** to cluster the table data. The order of columns determines the sort hierarchy. |
| **Table Expiration** | **Toggle**: True/False <br/> Enables or disables the automatic expiration of the table. |
| **Expiration Type** | **Dropdown**: Select how the expiration is calculated. <br/>- **EXACT DATE/DATETIME**: The table will expire at a specific point in time. <br/>- **DAYS FROM NOW**: The table will expire after a set number of days from the deployment date. |
| **Expiration Value** | **Text Box**: Enter the value based on the selected Expiration Type. <br/>- For **EXACT DATE/DATETIME**, use format: `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS` (e.g., `2024-12-31`). <br/>- For **DAYS FROM NOW**, enter an integer (e.g., `30`). |
| **Default Rounding Mode** | **Dropdown**: (Optional) Specify the rounding behavior for numeric calculations. <br/>- `ROUND_HALF_AWAY_FROM_ZERO` <br/>- `ROUND_HALF_EVEN` |

##### Factless Fact Advanced Deploy Load Options

<img width="379" height="329" alt="image" src="https://github.com/user-attachments/assets/8d962b14-4d8a-4dc3-ada7-e5b79e453cbf" />

| **Setting** | **Description** |
|---------|-------------|
| **Multi Source** | Toggle: True/False<br/>Implementation of SQL UNIONs<br/>**True**: Combine multiple sources using `UNION ALL` or `UNION DISTINCT`. |
| **Truncate Before** | Toggle: True/False<br/>**True**: Table is truncated before every load.<br/>**False**: Incremental load based on update strategy. |
| **Distinct** | Toggle: True/False<br/>**True**: Applies a DISTINCT clause to the data. |
| **Group By All** | Toggle: True/False<br/>**True**: Applies a GROUP BY ALL clause on columns. |

##### Factless Fact Advanced Deploy Other Options
<img width="374" height="433" alt="image" src="https://github.com/user-attachments/assets/990bb1cc-cc7f-47a5-a29c-fde087396c85" />

| **Setting** | **Description** |
|---------|-------------|
| **Enable tests** | Toggle: True/False<br/>Determines if tests are enabled |
| **Pre-SQL / Post-SQL**| SQL to execute before or after the Fact load operation. |

<img width="585" height="550" alt="image" src="https://github.com/user-attachments/assets/35f3290e-52f1-4669-b758-778a1bb65dfe" />

> [!WARNING]
> **Destructive Change:** Modifying partitioning settings on a deployed table will cause the table to be **dropped and recreated** during the next deployment.<br/>

> [!WARNING]
> **Destructive Change:** Similar to partitioning, modifying clustering columns on an existing table will cause the table to be **dropped and recreated**.

#### Factless Fact Advanced Deploy System Columns

These columns are automatically added to manage fact logic:

| **Column** | **Description** |
|----------|-------------|
| **system_create_date** | Audit timestamp for when the row was first inserted. |
| **system_update_date** | Audit timestamp for the last modification. |

## BigQuery SCD Implementation Preferences

* **Optimization:** For tables exceeding **10 million rows**, ensure the table is **partitioned** and **clustered** to minimize the bytes scanned during the MERGE operation.

### Factless Fact Advanced Deploy Joins

Join conditions and other clauses can be specified in the join space next to mapping of columns in the UI.

> 📘 **Specify Group by Clauses**
>
> Best Practice is to specify group by clauses in this space if you are not opting for the group by all provided in OPTIONS config.

### Factless Fact Advanced Deploy Deployment

#### Factless Fact Advanced Deploy Initial Deployment

When deployed for the first time into an environment the Fact node of materialization type table or view will execute the following stage:

| **Stage** | **Description** |
|-----------|----------------|
| **Create Fact Table** | This will execute a CREATE OR REPLACE statement and create a table in the target environment |


#### Factless Fact Advanced Deploy Redeployment

Once a Factless Fact table is initially deployed, subsequent configuration changes will result in either an in-place **`ALTER`** or a full **`DROP and RECREATE`** of the table, depending on the nature of the update (e.g., destructive changes like partitioning or clustering will trigger a recreation).

#### Altering the Factless Fact Tables

The following types of column or table modifications will result in an **`ALTER`** statement to update the table structure in the target environment, whether these changes are made individually or in combination:

*   **Primary Key Updates:** Adding/Updating/Modifying non-enforced primary key constraints.
*   **Table Metadata:** Rename or updating descriptions.
*   **Column Structure Changes:** 
    *   Adding new columns.
    *   Dropping existing columns.
    *   Renaming columns.
*   **Column Attribute Modifications:** Changing descriptions, data types or adjusting nullability constraints (e.g., `NULL` to `NOT NULL`).
*   **Configuration & Option Changes:**
    *   Updating **Table Expiration** or **Partition Expiration** settings.
    *   Adjusting the **Default Rounding Mode**.

The following stages are executed:

| **Stage** | **Description** |
|-----------|----------------|
| **ALTER TABLE** | Alter table statement is executed to perform the alter operation |

#### Drop and Recreate Factless Fact Table

| **Change** | **Stages Executed** |
|------------|-------------------|
| **Any materialization to Table** |  1. Drop `materialization`<br/>2. Create Fact table |

### Factless Fact Advanced Deploy Undeployment

If a Fact Node of materialization type table is deleted from a Workspace, that Workspace is committed to Git and that commit deployed to a higher level environment then the Fact Table in the target environment will be dropped.

The stage executed:

| **Stage** | **Description** |
|-----------|----------------|
| **Drop table** | Removes the table from the environment |

---

## Code

### Work Advance Deploy Code

* [Node definition](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/WorkAdvanceDeploy-170/definition.yml)
* [Create Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/WorkAdvanceDeploy-170/create.sql.j2)
* [Run Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/WorkAdvanceDeploy-170/run.sql.j2)

### Persistent Stage Advance Deploy Code

* [Node definition](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/PersistentStageAdvancedDeploy-171/definition.yml)
* [Create Template](https://github.com/coalesceio/big-query-base-node-types/blob/main/nodeTypes/PersistentStage-160/create.sql.j2)
* [Run Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/PersistentStageAdvancedDeploy-171/run.sql.j2)

### Dimension Advance Deploy Code

* [Node definition](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/DimensionAdvancedDeploy-388/definition.yml)
* [Create Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/DimensionAdvancedDeploy-388/create.sql.j2)
* [Run Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/DimensionAdvancedDeploy-388/run.sql.j2)

### Fact Advance Deploy Code

* [Node definition](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/FactAdvancedDeploy-389/definition.yml)
* [Create Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/FactAdvancedDeploy-389/create.sql.j2)
* [Run Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/FactAdvancedDeploy-389/run.sql.j2)


### Factless Fact Advance Deploy Code

* [Node definition](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/FactlessFactAdvancedDeploy-177/definition.yml)
* [Create Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/FactlessFactAdvancedDeploy-177/create.sql.j2)
* [Run Template](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/nodeTypes/FactlessFactAdvancedDeploy-177/run.sql.j2)

[Macros](https://github.com/coalesceio/big-query-base-node-types-advanced-deploy/blob/main/macros/macro-1.yml)
