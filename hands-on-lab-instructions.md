# Transform data using dbt Jobs in Microsoft Fabric Warehouse

**90-minute hands-on lab**

The environment is prepared before the session. Each assigned workspace already contains:

- Warehouse: `sales_warehouse`
- dbt Job: `sales_dbt_job`

## Participant assignment

Use the same three-digit suffix:

- `dbt-user-001` → `dbt-fabric-ws-001`
- `dbt-user-002` → `dbt-fabric-ws-002`

Use only the workspace matching your assigned user number.

## Lab flow

Sign in → verify prepared items → load seed data → configure dbt Job → **import prepared project** → run → DAG → test → schedule → verify → semantic model.

## Exercise 1: Sign in and open your workspace
1. Open the instructor-provided Fabric portal - fabric.microsoft.com. Use incognito window for isolating your lab experience.
2. Sign in with the assigned account. 
	![Sign in to the Microsoft Fabric portal](Images/login.png)
3. Provide password and Sign-in. You will be asked to update password. On successful update, you will succefully sign-in.
    ![Update the temporary account password](Images/update_password.png)
3. Complete "Welcome to the Fabric view" guided tour. 
    ![Complete the Fabric welcome tour](Images/fabric_tour.png)
4. Click on workspaces in left navigation to view the workspace assigned to you for this lab. The workspace name will be *dbt-fabric-test-ws-{xxx}. xxx in workspace name matches with the number assigned to your account. In my scenario, the user name is *dbt-test-002* and workspace name is *dbt-fabric-test-ws-002*
    ![Open the Workspaces list in Fabric](Images/view_workspaces.png)

**Success:** You can see a workspace created for you to begin the lab.

## Exercise 2: Verify prepared items
1. Click on the workspace name. You will be directed to workspace view.
    ![View the assigned Fabric workspace](Images/workspace_view.png)
2. Confirm that you see two items are present in the list - `sales_warehouse` and `sales_dbt_job` .
2. Click on `sales_warehouse` to open the warehouse.
    ![Open the sales warehouse](Images/open_warehouse.png)

**Success:** The Warehouse opens successfully.

## Exercise 3: Create seed tables
1. Click on New SQL Query to open the query editor.
    ![Create a new SQL query](Images/new_sql_query.png)
2. Copy-paste SQL statements in [`sql/01_create_seed_tables.sql`](sql/01_create_seed_tables.sql) and in SQL editor.
    ![Paste the seed table creation SQL](Images/cp_paste_create_seed_tables.png)
3. Click on run and all statements will be executed successfully.
    ![Run the seed table creation SQL](Images/run_seed_tables.png)
4. Expand folder Schemas -> seed -> Tables folders to view created seed tables in the object explorer.

    ![View the seed tables in Object Explorer](Images/view_seed_tables_in_oe.png)

**Success:** Schema `seed` contains `customers`, `products`, and `orders`.

## Exercise 4: Load seed data
1. Similarly, copy paste SQL content in [`sql/02_load_seed_data.sql`](sql/02_load_seed_data.sql) file and execute/run queries.
    ![Execute the seed data SQL](Images/execute_seed_data.png)
2. You can verify the row count for each table in results grid.
    ![Verify the loaded seed data](Images/view_seed_data.png)

**Success:** 5 customers, 5 products, and 10 orders are loaded.

## Exercise 5: Configure the prepared dbt Job
1. Click on workspace in the left navigation pane and it will open workspace page.
    ![Return to the Fabric workspace page](Images/workspace_page.png)
2. Open `sales_dbt_job` item in the list under the workspace name (dbt-fabric-test-ws-002).
    ![Open the prepared dbt job item](Images/new_dbt_item.png)
3. Click on "Configure adapter settings" in the blue banner on top of the dbt job item page to configure dbt profile.
    ![Configure the dbt adapter profile](Images/dbt-profile-select.png)
4. Select `sales_warehouse` in OneLake Catalog in the list and click next. 
    ![Select the warehouse from the OneLake catalog](Images/choose_profile_from_ol.png)
5. Provide schema name and click Apply.
    ![Apply the dbt warehouse profile](Images/apply_profile.png)
6. You can click on adapter settings in the ribbon to update target profile.
    ![Open dbt adapter settings](Images/adapter_settings.png)

**Success:** The target points to the prepared Warehouse.

## Default path for Exercises 6–8: Import the prepared project

**Recommended for the 90-minute lab.**

1. Download `fabric-dbt-hol-project.zip` file at root of the github repository.
2. In `sales_dbt_job`, click on import a project tile.
    ![Import a project into the dbt job](Images/import_project.png)
3. Upload the zip file, downloaded in step 1.
4. Once you upload the zip file, Verify `dbt_project.yml`, `models/staging`, `models/marts`, and `models/schema.yml` files.
    ![Review the uploaded dbt project files](Images/uploaded_dbt_project.png)
5. To save uploaded changes, click save or "revert" button to discard and redo this exercise.
    ![Save or revert dbt project changes](Images/save-revert.png)
6. You can either save changes with issues or validate first and save later. Click validate in the ribbon. It will show any issues with dbt project. In my case, I deleted _MACOSX folder, autocreated during upload process
    ![Review dbt project validation issues](Images/validation.png)
**Success:** Source, staging, mart, and test files are visible.
7. Re-ran validation step to ensure no issues with dbt project.
    ![Confirm dbt project validation succeeds](Images/validation_no_issues.png)

## Exercise 9: Run models & tests
Run or build the staging models, followed by the mart models. If supported:

1. Make sure the dbt command in ribbon is build.
    ![Select the dbt build command](Images/command_build.png)
2. Click Run to build staging + mart models and run data tests configured.
3. You can see the status of run in the results pane. You can click on refresh to get the latest status of the dbt build.
    ![Monitor a dbt build in progress](Images/run_status_in_progress.png)
4. Upon completion you can verify the output, compiled sql for selected model or lineage view.
    ![Review the completed dbt build](Images/run_status_completed.png)

    ![Inspect compiled SQL for a dbt model](Images/compiled_sql.png)

    ![View dbt model lineage](Images/lineage.png)
**Success:** All six models complete successfully.

## Exercise 10: Run selected models

1. You can run selected models by running them manually from editor. Open a mart model dim_customer and click on Run/compile/test/build a specific model as per your development need. I am running all data tests to ensure data correctness.

    ![Run tests for a selected dbt model](Images/selected_test_execution.png)


2. You can run selected models through Advanced settings. Click on Advanced setting in the ribbon and choose specific models and run them.
    ![Configure advanced dbt run settings](Images/run_advanced_settings.png)

**Success:** Configure model and execute specific dbt action in dbt job.

## Exercise 11: Schedule the dbt Job
1. Click on Schedule in Ribbon. 
2. You can add a schedule and configure failure notifications as needed.
    ![Open the dbt job schedule pane](Images/schedule_pane.png)
3. Configure and Save schedule
    ![Configure a dbt job schedule](Images/configure_schedule.png)

    ![View configured dbt job schedules](Images/schedules.png)

**Success:** An enabled schedule is visible.

## Exercise 12: Verify transformed data

1. Open Warehouse from `sales_dbt_job` item.
2. Copy paste [`sql/03_verify_marts.sql`](sql/03_verify_marts.sql) file and run the script in the Warehouse.
![Verify transformed warehouse data](Images/verify_data.png)

**Success:** `fct_sales` contains joined rows and calculated `sales_amount`.

## Exercise 13: Create a semantic model
; confirm relationships; save as `sales_semantic_model`.

1. Click on New semantic model in Warehouse.
![Create a new semantic model](Images/new_semantic_model.png)
2. Provide semantic model name - `sales_semantic_model`. Choose Direct Lake on OneLake as storage mode.Include `dim_customer`, `dim_product`, and `fct_sales` in jaffle_shop_dbo schema. Confirm and create semantic model.
![Configure the Direct Lake semantic model](Images/create_semantic_model.png)
3. Open workspace page and clikc on `sales_semantic_model` item. You can see semantic model with selected tables.
![View the created semantic model](Images/created_semantic_model.png)
**Success:** Three tables are present.

## Troubleshooting
- Missing prepared item: contact the instructor; do not use another participant's workspace.
- Wrong target: select `sales_warehouse` in the workspace matching the user suffix.
- Import issue: keep `dbt_project.yml` at the project root.
- Model not found: check filenames and `ref()` values exactly.
