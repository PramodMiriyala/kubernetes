## <mark>**SITE RELIABILITY ENGINEERING - OVERVIEW**</mark>

* Google has released a book in 2016 about how it runs production called it as Site Reliability Engineering 
  * **PATH:** `C:\temp\repos\kubernetes\Site Reliability Engineering_ How Google Runs Production Systems.pdf`
* Site Reliability Engineering Overview	
  * **PATH:** `C:\temp\repos\kubernetes\Site-Reliability-Engineering.pdf`
---
* **TRADITIONAL DEVELOPMENT**

<img src='images\SRE_01.png' alt='Early software deployment' width='700'>


* **DEVOPS BREAKS DOWN THE WALL BETWEEN DEV AND OPS**
  * ALL THE MEMBERS HAVE A COMMON GOAL

<img src='images\SRE_02.png' alt='Early software deployment' height='400' width='700'>

## <mark>**Site Reliability Engineering (SRE)**</mark>

* **Site Reliability Engineering (SRE)** is a discipline that **combines software engineering and IT operations** to create scalable and reliable systems.
* It was developed by Google in 2003 to enhance the reliability of its services by applying engineering best practices to operational tasks.

## <mark>**SRE 4 Golden Signals**</mark>

* **Latency**: the time it takes to serve a request.
* **Traffic**: the total number of requests across the network.
* **Errors**: the number of requests that fail.
* **Saturation**: the load on your network and servers.

### **SRE 4 Golden Signals USES**
* they **measure** things that represent the **most fundamental aspects of your service’s functions**. 
* **The golden signals are mainly used for**:
	* **Troubleshooting various components** of the system **to find the root cause and fix** the problem.
	* **Alerting the response team about an incident** when the signals drop too low, so they can identify the problem and work towards its remediation.
	* **Capacity planning to consistently monitor** and improve things over time.

---
### **key principles associated with SRE:**
* **Accept Failure as Normal**
* **Implement Gradual Changes**
* **Leverage Tooling and Automation**
* **Measure Everything**
---
### **Responsibilities of Site Reliability Engineers**
*	**System Stability and Reliability**: Ensuring systems are reliable, available, and performant.
*	**Incident Response Management**: Developing systematic approaches for incident management to mitigate disruptions effectively.
*	**Collaboration with Development Teams**: Working closely with developers to ensure operational considerations are integrated into software design and deployment processes.

---

## <mark>Reliability Testing for SLAs</mark>

### <mark>**Service Level Agreement (SLA)**</mark> 
A Service Level Agreement (SLA) is a formal contract between a service provider and a customer that outlines the expected level of service to be delivered. It serves as a critical tool for managing expectations and ensuring accountability in service delivery.

### <mark>Key Components of an SLA</mark>

#### **1. Agreement Overview**
This section includes the start and end dates of the SLA, details of the parties involved, and an overview of the services covered.

#### **2. Description of Services**
SLAs specify the services provided, including turnaround times, technologies used, maintenance schedules, and procedures.

#### **3. Service Level Objectives (SLOs)**
These are specific metrics agreed upon by both parties that outline expected performance levels, such as uptime percentages and response times.

#### **4. Exclusions**
This section details what is not covered under the SLA, clarifying any limitations or exemptions.

#### **5. Consequences for Non-Compliance**
The SLA outlines actions to be taken if service levels are not met, which may include financial penalties, additional support, or other remedies.

### Types of SLAs

- **Customer-Level SLA**: Covers all services used by a specific customer.
- **Service-Level SLA**: Details identical services offered to multiple customers.
- **Multi-Level SLA**: Integrates various conditions for different customer tiers or service levels.

---

### <mark>**Reliability Testing**</mark>
* Reliability testing focuses on ensuring that software meets specific performance standards over time, which is often defined by **SLAs**. 
* This type of testing evaluates how well an application performs under expected conditions and helps identify potential points of failure.

### Implementing Reliability Testing
Incorporating reliability testing into the DevOps framework involves:

- **DevOpRET Approach**: This method integrates reliability testing into acceptance testing stages, focusing on operational performance to ensure that applications can meet SLA requirements consistently.
- **Monitoring and Feedback**: 
  - Continuous monitoring of applications in production helps identify issues proactively. 
  - This includes **synthetic transaction monitoring** to detect failures in third-party services before they impact users.
    - **Synthetic transaction monitoring (STM)** is a proactive monitoring technique used to assess the performance and availability of applications by simulating user interactions. This method employs scripts or automated "robots" to mimic the actions that real users would take when interacting with a system, such as logging in, navigating through pages, or completing transactions.

### Benefits of Reliability Testing
* By integrating reliability testing into the CI/CD pipeline, organizations can ensure that their applications are always ready for deployment.
* This proactive approach reduces downtime and enhances user satisfaction by maintaining service quality as per SLAs.

---
---


## <mark>**Issues within teams without Site Reliability Engineering (SRE) approach**</mark>

The **blame game** between testers, developers, and operations engineers often arises in environments lacking a Site Reliability Engineering (SRE) approach.

<img src='images\SRE_03.png' alt='Blame game' width='700'>

### **The Blame Game Dynamics**
* **Siloed Teams**
* **Communication Breakdown**
* **Lack of Accountability**

---

## <mark>***Solving the BlameGame with SRE***</mark>

### <mark>**1. SRE’s basic principle is - 100% is not a real target**</mark>
  * Define Availability
  * Level of availability
  * Plan in case of failure
---

* Define What Availability is in the context of your application
* To achieve this We define **Service Level Indicator (SLI)**

#### **SLI (Service Level Indicator)**

* Service Level Indicators (SLIs) are specific metrics used to **measure the performance and reliability of a service** from the perspective of the end user. 
* **Common SLIs :**
  - **Request Latency**
    - This measures the time taken to process a request and return a response.
  - **BatchThroughput**
    - This refers to the number of requests processed in a given time period, often measured in requests per second (RPS).
  - **Failures per request**
    - This SLI measures the error rate by calculating the number of failed requests compared to the total number of requests made.
* Service Level indicator depicts the metric on the
current period of time
* Using SLI Define SLO
* Example: 95 percent of the homepage requests over past 5
	minutes have a latency less than 200 ms

#### **SLO (Service Level Objective)**

* Defines specific performance targets for a service over a designated period. It serves as a benchmark for measuring the reliability and performance of services
* Binding target for collection of SLIs
* From SLO we derive SLA
* Example:
  - 99.9% of the requests over a year will have homepage
  SLI (latency < 300ms)

#### **SLA (Service Level Agreement)**
* More of a commercial agreement, if your service/application is out of spec according to contract
* Example:
  - Customer will receive Service credit if SLI (latency < 300)
  succeeds less than 99.5% of request over the year.

**SLI'S DRIVE SLO'S WHICH INFORM SLA'S**

### <mark>**2. RISKS AND ERROR BUDGETS**</mark>

#### **Risk and Availability**
* 100 % availability is not a good idea.
* In many cases user will not experience your availability
due to other issues.
* Example:
  - Your service is available for 99.99 % and your customer
  uses this on a mobile where network availability is only
  99%. In such cases due to other reasons user’s
  availability might be equal to less that 99%
* So we have to accept some degree of failures to deliver
the features/products
* `How?`
* That’s what Error Budgets are for

#### **Error Budgets**

* Acceptable Risk of the system dictates SLO and SLO
defines the error Budget
* SLO = 99.9 % available per month
* If you calculate what is time which your services
unavailability would be, that defines Error Budgets
* In the above case = 0.1% per month = (0.1* 30 * 24 *
60/100) = 43.2 Minutes/month
* If the Error Budget is exceeded the feature deployments will be halted, so now it’s a common decision which the Product and SRE team has to make when they are deploying risky features
* Error Budgets needs to monitored by a monitoring system
---

### <mark>**TOIL**</mark>

**Definition of Toil**
Toil refers to the type of work associated with running production systems that exhibits the following characteristics:

- **Manual**: Requires human intervention and cannot be performed automatically.
- **Repetitive**: Involves tasks that are performed frequently and consistently.
- **Automatable**: Suitable for automation; tasks that can be scripted or programmed to reduce manual effort.
- **Tactical**: Focused on immediate operational needs rather than long-term strategic goals.
- **Lacks Long-Term Value**: Does not contribute significantly to the overall improvement or innovation of services.
- **Scales Linearly with Service Growth**: As the service grows, the amount of toil increases proportionally.
- **Worth Automating**: Tasks that should be automated to improve efficiency and reduce manual workload.

### **Scenario Example**
- **Question**: I received an alert at 2 AM and had to restart a service, which took approximately 2 hours. Later, from 10 AM to 4 PM, I wrote a script to automate this process to prevent future occurrences. Are the 2 hours spent at night plus the 6 hours spent on automation considered toil?
  
- **Answer**: The 2 hours spent responding to the alert in the middle of the night is classified as toil, as it involved manual intervention in a repetitive task. However, the 6 hours spent developing the automation script is not considered toil; instead, it is an engineering activity aimed at reducing future toil.

### **Goal of Reducing Toil**
- The primary objective is to minimize toil and focus on engineering activities that add long-term value to the system and organization.
- While it is essential to reduce toil, completely eliminating all forms of toil may not be feasible or worthwhile. The focus should be on identifying high-impact areas for automation and improvement.

---
### <mark>**Reducing Noise from Alerts**</mark>

**Overview**
Having too many alerts can overwhelm on-call engineers and lead to alert fatigue, which negatively impacts their effectiveness and overall system reliability. Reducing alert noise is essential for maintaining optimal performance and ensuring that critical issues are addressed promptly.

### **Strategies to Reduce Alert Noise**

1. **Prioritize Critical Alerts**
2. **Implement Fast Burn and Slow Burn Alerts**
3. **Set Appropriate Thresholds**
4. **Alert Deduplication and Grouping**
5. **Suppress Low-Priority Alerts During Maintenance**
6. **Leverage Modern Monitoring Tools**:
7. **Empower Engineers with Contextual Information**
8. **Continuous Improvement**

---
---

## <mark>**Observability**</mark>

<img src='images\SRE_04.png' alt='Early software deployment' width='400'>

* We need to make our systems observable.
* **Observability** breaks down into **three key areas**:
	* **Logs**
	* **Metrics**
	* **Traces**


| **Pillar**  | **Definition**                                                                              | **Key Points**                                                                                       | **Use Cases**                                      | **Examples**                                                                 |
|-------------|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|---------------------------------------------------|------------------------------------------------------------------------------|
| **Logs**    | Chronological records of events and actions in a system.                                    | - Capture every activity, event, and message.<br>- Enable root cause analysis.<br>- Rich in context. | Debugging, auditing, and error diagnosis.        | - Error logs from a crashed application<br>- Login attempts in an auth system<br>- File access logs |
| **Metrics** | Quantitative measurements that track the health and performance of a system.                | - Provide insights into performance.<br>- Useful for trend analysis.<br>- Lightweight to store.      | Capacity planning, anomaly detection.            | - CPU utilization (%), Memory usage (MB)<br>- API latency (ms), Requests per second<br>- Disk I/O rates |
| **Traces**  | Records of the journey of requests in a system.                                             | - Map how requests travel.<br>- Help identify bottlenecks.<br>- Capture relationships between services. | Troubleshooting, optimization, performance tuning.| - Trace of a user request through multiple microservices<br>- Timeline showing latency between services<br>- Root cause analysis of slow API calls |

### Added Examples for Each Pillar:
1. **Logs**:
   - **Error logs**: `2024-12-26 12:30:45 ERROR [app.py]: Unable to connect to database.`
   - **Auth logs**: `2024-12-26 12:31:10 INFO [auth]: User john_doe logged in.`
   - **System logs**: Kernel events or hardware failures.

2. **Metrics**:
   - **System metrics**: `CPU usage: 85%`, `Memory utilization: 2.3GB/4GB`.
   - **Application metrics**: `API response time: 250ms`, `Error rate: 1%`.
   - **Database metrics**: `Query performance: 0.02s`, `Connections open: 10`.

3. **Traces**:
   - Trace of a **user request** through services: 
     - **Service A** → **Service B** → **Database** → Response.
   - Example visualization:
     - Service A latency: **50ms**, Service B latency: **120ms**, Database latency: **200ms**.
   - **Distributed Tracing Tools**: OpenTelemetry, Jaeger, Zipkin.

---
### <mark>**Incident Management**</mark>

* Try to form a Team which was Responsable for Solving this Issue

#### **Roles in Incident Management**

* **Incident Commander**
	* Responsible for making key decisions and Plan
	* Assigning roles to others (delegation)
* **Operations Lead**
  * Who has detailed understanding of system
* **Communications Lead**
  * Responsible for communicating to external stake holders
* **Planning Lead**
	* Responsible for Writing the Plan
	* Writing Postmortem document.

Here's a modified version of your notes for clarity and readability:

---

### <mark>**Learning from Incidents - Postmortem**</mark>

#### **Blameless Postmortem Metadata**

- **What systems were affected?**  
- **Who was involved in responding?**  
- **How did we discover the incident?**  
- **When did the response begin?**  
- **What mitigations were deployed?**  
- **When was the incident resolved?**  

---

#### **Who Contributes to Writing the Postmortem Document**

- **Initial Draft:** The Incident Commander starts by drafting this document.  
- **Collaboration:** All individuals involved in the incident are encouraged to collaborate and contribute to the postmortem.  

---

#### **Key Principles**

- **Blamelessness:** Treat system failures as systemic issues, not human errors.  
- **Comprehensive Analysis:** Focus on all contributing factors rather than identifying a single root cause.  

--- 
### How Google Encouraged Such Culture

#### **1. Recognizing Courage and Accountability**  
- Google emphasizes the value of owning up to mistakes as a sign of **leadership and maturity**.  
- Writing a thorough and transparent postmortem demonstrates that an individual is solution-oriented and committed to systemic improvement.  
- Leaders often acknowledge such behavior publicly, framing it as a **positive example for others.**


#### **2. Using Mistakes as Success Stories**  
- Google encourages teams to treat resolved incidents as **success stories**.  
  - The person who took ownership of the mistake and postmortem is often positioned as someone who **drove positive change** in the organization.  
  - Their role in reducing the likelihood of similar incidents is celebrated.

---

## <mark>**Observability Tools**</mark>

### **Popular Observability Tools**

| **Tool**                      | **Purpose**                                           | **Key Features**                                                                                     | **Use Cases**                               |
|-------------------------------|------------------------------------------------------|------------------------------------------------------------------------------------------------------|---------------------------------------------|
| **Prometheus**                | Open-source monitoring and alerting tool             | - Flexible querying language (PromQL) <br> - Time-series data collection and storage <br> - Integration with Grafana for visualization | Monitoring infrastructure and microservices |
| **Grafana**                   | Visualization platform for metrics, logs, and traces | - Customizable dashboards <br> - Supports multiple data sources (Prometheus, Elasticsearch, etc.)   | Building interactive dashboards for real-time system insights |
| **Elastic Stack (ELK)**       | Log analysis and full-text search                    | - Scalable storage for logs <br> - Powerful search capabilities <br> - Rich visualizations with Kibana | Analyzing server logs, error patterns, and debugging |
| **Datadog**                   | All-in-one monitoring and observability platform     | - Metrics, logs, and traces in a single interface <br> - Advanced alerting and anomaly detection <br> - AI-powered root cause analysis | Cloud infrastructure monitoring, service dependency mapping |
| **OpenTelemetry**             | Open-source standard for collecting telemetry data   | - Vendor-neutral instrumentation <br> - Wide adoption across cloud-native ecosystems                 | Standardized observability for microservices and distributed systems |
| **Splunk**                    | Enterprise-grade log aggregation and analysis        | - Advanced machine learning for anomaly detection <br> - Scalable for large enterprise environments   | Security monitoring, compliance, and IT operations |
| **Jaeger**                    | Distributed tracing tool                              | - Request flow visualization <br> - Root cause identification in complex service architectures       | Debugging latency and bottlenecks in distributed systems |


### <mark>**Prometheus**</mark>

* Prometheus is primarily designed for monitoring and alerting through the collection and storage of metrics rather than logs.

[Refer Here](https://docs.aws.amazon.com/eks/latest/userguide/deploy-prometheus.html) for prometheus installation.

* If you want to allow **port-forwarding** to listen on all network interfaces (not just `localhost`), you can add the `--address 0.0.0.0` option to the port-forwarding command. 

<img src='images\SRE_05.png' alt='Prometheus_architecture' width='800'>

### **Key Components in the Diagram:**

#### 1. **Prometheus Server**
   - **Core Functionality**: The central component responsible for scraping and storing metrics.
   - **Key Features**:
     - **Retrieval**: Pulls metrics from targets (e.g., jobs, exporters).
     - **Storage**: Stores the metrics in a time-series database optimized for fast retrieval.
     - **PromQL**: Prometheus Query Language used to query and analyze the metrics data.

#### 2. **Service Discovery**
   - Dynamically finds monitoring targets using integrations like:
     - **DNS**: Discovers services via DNS-based configurations.
     - **Kubernetes**: Monitors Kubernetes pods, services, and nodes.
     - **Consul**: Discovers targets registered in a Consul service registry.
     - **Custom Integrations**: Allows custom configurations for target discovery.

#### 3. **Jobs/Exporters**
   - **Exporters**: Components that expose metrics in a format Prometheus can scrape. Examples include:
     - **Node Exporter**: Provides hardware and OS metrics.
     - **Blackbox Exporter**: Probes endpoints for availability.
   - **Jobs**: Applications or services that expose Prometheus metrics endpoints.

#### 4. **Pushgateway**
   - **Purpose**: Handles metrics from short-lived jobs that cannot expose metrics directly. These jobs push their metrics to the Pushgateway, which Prometheus scrapes.

#### 5. **Alertmanager**
   - **Function**: Manages alerts generated by Prometheus.
   - **Workflow**:
     - Prometheus pushes alerts to Alertmanager based on predefined rules.
     - Alertmanager sends notifications via integrations like **PagerDuty**, **Email**, or other channels.
   - **Role**: Ensures that alerts are routed and grouped effectively to avoid alert fatigue.

#### 6. **Web UI, Grafana, API Clients**
   - **Web UI**: Provides a basic interface to query metrics using PromQL.
   - **Grafana**: A popular tool for creating advanced, visually rich dashboards using Prometheus as a data source.
   - **API Clients**: Allow programmatic access to metrics and data stored in Prometheus.

#### 7. **HDD/SSD Node**
   - Prometheus stores metrics locally on disk, either on an **HDD** or **SSD** depending on the environment and requirements.

---


### **How Prometheus Works:**
1. **Data Collection**:
   - Prometheus pulls metrics from targets using HTTP endpoints exposed by exporters or services.
   - For dynamic environments, it uses service discovery to automatically find new targets.

2. **Data Storage**:
   - The scraped metrics are stored in a time-series database with timestamps and labels (key-value pairs) for filtering and grouping.

3. **Querying with PromQL**:
   - PromQL allows users to query data for insights, visualizations, and creating alerts.

4. **Alerting**:
   - Prometheus generates alerts based on conditions specified in its configuration and forwards them to Alertmanager for processing and notification.

---

### **Use Cases of Prometheus**
- **Infrastructure Monitoring**: Collecting and analyzing server and network metrics.
- **Application Performance Monitoring (APM)**: Tracking application health and performance.
- **Kubernetes Monitoring**: Observing workloads, pods, and nodes in Kubernetes environments.
- **Alerting and Incident Management**: Detecting and notifying about issues proactively.

[Refer Here](https://promlabs.com/promql-cheat-sheet/) for Promql cheat sheet

## <mark>**Grafana**</mark>

* Grafana is a visualization platform that specializes in creating rich, interactive dashboards. While it can query data from multiple sources (including Prometheus), its primary strength lies in its ability to present data visually in various formats (graphs, charts, etc.).
* Grafana does not collect metrics; instead, it **relies on data sources like Prometheus** to provide the necessary data for visualization.

[Refer Here](https://grafana.com/docs/grafana/latest/setup-grafana/installation/helm/) for grafana installation

* After Executing the command `helm install my-grafana grafana/grafana --namespace monitoring` copy the Responce.
  * To generate admin password & port forwarding command

* If you want to allow **port-forwarding** to listen on all network interfaces (not just `localhost`), you can add the `--address 0.0.0.0` option to the port-forwarding command.

<img src='images\SRE_07.png' alt='grafana_dashsource' width='800'>

<img src='images\SRE_08.png' alt='grafana_dashsource' width='800'>

<img src='images\SRE_09.png' alt='grafana_dashsource' width='800'>

<img src='images\SRE_10.png' alt='grafana_dashsource' width='800'>

<img src='images\SRE_11.png' alt='grafana_dashsource' width='800'>

---

### **Commonly Used Kubernetes Dashboards**  
1. **ID 315** - ["Kubernetes / Compute Resources / Namespace (Pods)"](https://grafana.com/grafana/dashboards/315)  
   - **Focus**: Displays resource usage (CPU, memory, etc.) at the namespace and pod levels.  
   - **Use Case**: Import this dashboard to gain detailed insights into how namespaces and pods are consuming resources.

2. **ID 747** - ["Kubernetes Capacity Planning"](https://grafana.com/grafana/dashboards/747)  
   - **Focus**: Provides insights into cluster capacity planning, including CPU and memory usage trends across the cluster.  
   - **Use Case**: Great for cluster growth forecasting and resource allocation.

3. **ID 741** - ["Kubernetes Monitoring"](https://grafana.com/grafana/dashboards/741)  
   - **Focus**: General Kubernetes monitoring, including node health, resource utilization, and pod metrics.  
   - **Use Case**: A great starting point for an overview of your Kubernetes environment.

4. **ID 1860** - ["Kubernetes Cluster Monitoring"](https://grafana.com/grafana/dashboards/1860)  
   - **Focus**: Cluster-wide metrics, pod states, and node health.  
   - **Use Case**: Useful for gaining a holistic view of cluster performance.

5. **ID 8588** - ["Kubernetes / Compute Resources / Pod"](https://grafana.com/grafana/dashboards/8588)  
   - **Focus**: Pod-specific resource utilization (CPU, memory).  
   - **Use Case**: Helpful for troubleshooting individual pod performance issues.

6. **ID 12740** - ["Kubernetes Networking"](https://grafana.com/grafana/dashboards/12740)  
   - **Focus**: Monitors networking metrics such as traffic, bandwidth, and dropped packets.  
   - **Use Case**: Ideal for analyzing network performance in the cluster.

7. **ID 3131** - ["Kubernetes Persistent Volume Monitoring"](https://grafana.com/grafana/dashboards/3131)  
   - **Focus**: Monitoring persistent volumes and storage utilization.  
   - **Use Case**: Essential for tracking storage resources in a stateful environment.

8. **ID 6417** - ["Kubernetes / Compute Resources / Cluster"](https://grafana.com/grafana/dashboards/6417)  
   - **Focus**: Overall cluster health and resource usage trends.  
   - **Use Case**: Suitable for cluster-wide resource overview.

---

### **Steps to Import These Dashboards**

1. **Navigate to Grafana → Create → Import**.
2. Use the dashboard ID for the desired Kubernetes dashboard:
   - `315` for namespace-level metrics.
   - `747` for capacity planning.
   - `741` for general Kubernetes monitoring.
   - `1860` for cluster-wide metrics and node health.
   - `8588` for detailed pod-level monitoring.
   - `12740` for network performance.
   - `3131` for persistent volume monitoring.
   - `6417` for overall cluster health.
3. Click **Load**.
4. Select the Prometheus data source that was configured earlier.
5. Click **Import** to add the dashboard to your Grafana instance.

---
---

## <mark>Getting Logs from kubernetes</mark>

### **Popular Log Agents**

1. **Fluentd**: A widely-used log aggregator that can route logs to various destinations (e.g., Elasticsearch, Loki, Splunk).
2. **Loki**: A lightweight, Prometheus-style log aggregation system, specifically designed to work seamlessly with Grafana.
3. **Elastic Beats**: A set of lightweight shippers (e.g., Filebeat) to send logs to Elasticsearch.


### **Comparison of Different Approaches**
| **Approach**          | **Best For**                                                | **Ease of Use** | **Flexibility** |
|------------------------|------------------------------------------------------------|-----------------|-----------------|
| **Exporters**          | Existing applications or systems (e.g., databases, hosts). | High            | Medium          |
| **Client Libraries**   | Applications with custom metrics.                          | Medium          | High            |
| **OpenTelemetry**      | Unified observability (metrics, traces, logs).             | Medium          | Very High       |

---

### **Step-by-Step: Setting Up Loki on Kubernetes**

#### **1. Install Loki Using Helm Chart**

1. **Add the Grafana Helm Repository**:
   ```bash
   helm repo add grafana https://grafana.github.io/helm-charts
   helm repo update
   ```

2. **Install Loki Stack**:
   The Loki stack includes Loki, Promtail (log collector), and Grafana (optional).
   ```bash
   helm install loki grafana/loki-stack --namespace monitoring --create-namespace
   ```

   - By default, Promtail will be deployed to collect logs from Kubernetes pods and send them to Loki.
   - You can customize the Helm chart values using a `values.yaml` file (optional).

3. **Verify Installation**:
   Check that Loki and Promtail are running:
   ```bash
   kubectl get pods -n monitoring
   ```
   You should see pods for Loki and Promtail.

---

#### **2. Install Grafana**

If Grafana is not already installed, follow these steps:

1. **Install Grafana Using Helm**:
   ```bash
   helm install grafana grafana/grafana --namespace monitoring
   ```

2. **Get Grafana Admin Password**:
   ```bash
   kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode
   ```

3. **Access Grafana UI**:
   - Port-forward Grafana to your local machine:
     ```bash
     kubectl port-forward svc/grafana -n monitoring 3000:80
     ```
   - Open Grafana in a browser: [http://localhost:3000](http://localhost:3000).
   - Log in with:
     - Username: `admin`
     - Password: The password retrieved in the previous step.

---

#### **3. Add Loki as a Data Source in Grafana**

1. **Go to Data Sources**:
   - In the Grafana UI, navigate to **Configuration → Data Sources**.
   - Click **Add data source**.

2. **Select Loki**:
   - Choose **Loki** from the list of available data sources.

3. **Configure Loki**:
   - URL: `http://loki:3100` (use the Kubernetes service name for Loki).
   - Click **Save & Test** to verify the connection.

---

#### **4. Create a Dashboard in Grafana to View Logs**

1. **Create a New Dashboard**:
   - In Grafana, go to **Dashboards → New Dashboard → Add a new panel**.

2. **Query Loki for Logs**:
   - Use the **Explore** tab to test log queries and refine them.
   - Example Query: `{job="kubernetes-pods"}` (fetches logs from all Kubernetes pods).

3. **Configure Panel**:
   - Select the **Logs** visualization type for the panel.
   - Add filters or labels to narrow down the logs (e.g., namespace, pod name).

4. **Save the Dashboard**:
   - Save the dashboard with a meaningful name.

---

### **Optional: Customizing Promtail Configuration**

Promtail collects logs from Kubernetes pods and forwards them to Loki. You can customize its configuration to filter logs or add custom labels.

1. **Edit Promtail ConfigMap**:
   ```bash
   kubectl edit configmap loki-promtail -n monitoring
   ```

2. **Sample Promtail Configuration**:
   ```yaml
   scrape_configs:
   - job_name: kubernetes-pods
     kubernetes_sd_configs:
     - role: pod
     relabel_configs:
     - source_labels: [__meta_kubernetes_pod_label_app]
       target_label: app
     - source_labels: [__meta_kubernetes_namespace]
       target_label: namespace
     - source_labels: [__meta_kubernetes_pod_name]
       target_label: pod_name
   ```

3. **Apply Changes**:
   After modifying the configuration, restart Promtail:
   ```bash
   kubectl rollout restart deployment loki-promtail -n monitoring
   ```

---

### **Key Queries for Logs in Loki**

- **Fetch All Logs**:
  ```text
  {job="kubernetes-pods"}
  ```

- **Filter by Namespace**:
  ```text
  {namespace="default"}
  ```

- **Filter by Pod Name**:
  ```text
  {pod_name="my-app-pod"}
  ```

- **Search for Specific Terms in Logs**:
  ```text
  {namespace="default"} |= "error"
  ```

---
---

## <mark>How to scrape application metrics ?</mark>

* Getting Metrics from application into Prometheus
  * Exporters: To get metrics from well known servers (good for existing code.)
  * Prometheus Client
  * Open telemetry

* Logs:
  * Any enterprise apps generate logs
  * If the logs are written to files use **log agents** (**popular: fluentd**)
  * Developers can code to directly send logs to centralized log server

* Traces:
  * There are many apm (application performance monitoring) tools to scrape traces
    * Ex: **Dynatrace**, **Datadog**, **Splunk**, etc.,
  * For sending traces of your application to almost any tool there is a standard called as open telemetry.

---


### <mark>**OpenTelemetry**</mark>
OpenTelemetry is a modern observability framework for collecting **metrics, traces, and logs**. It allows you to export metrics to Prometheus and many other backends.

1. **Advantages of OpenTelemetry**:
   - Vendor-neutral observability.
   - Unified instrumentation for metrics, traces, and logs.
   - Supports multiple exporters (e.g., Prometheus, Jaeger, Tempo).

2. **Steps to Use OpenTelemetry for Metrics**:
   - **Install OpenTelemetry SDK**:
     Example for Python:
     ```bash
     pip install opentelemetry-api opentelemetry-sdk opentelemetry-exporter-prometheus
     ```

   - **Instrument Your Application**:
     Use OpenTelemetry SDK to record metrics. Example in Python:
     ```python
     from opentelemetry import metrics
     from opentelemetry.sdk.metrics import MeterProvider
     from opentelemetry.exporter.prometheus import PrometheusMetricReader
     from prometheus_client import start_http_server
     import random
     import time

     # Start Prometheus client server
     start_http_server(8000)

     # Set up OpenTelemetry Meter Provider
     reader = PrometheusMetricReader()
     metrics.set_meter_provider(MeterProvider(metric_readers=[reader]))
     meter = metrics.get_meter("example-meter")

     # Create a Counter
     request_counter = meter.create_counter(
         "app_requests", description="Number of processed requests"
     )

     # Record metrics
     while True:
         request_counter.add(1, {"service": "example-service"})
         time.sleep(random.random())
     ```

   - **Expose Metrics**:
     Metrics are exposed at the `/metrics` endpoint on port `8000`.

   - **Configure Prometheus**:
     Add the OpenTelemetry endpoint to `scrape_configs`:
     ```yaml
     scrape_configs:
       - job_name: 'otel-metrics'
         static_configs:
           - targets: ['localhost:8000']
     ```

   - **Optional: Use OpenTelemetry Collector**:
     OpenTelemetry Collector acts as an intermediary to collect and process telemetry data before exporting to Prometheus. You can deploy it in Kubernetes as a Helm chart:
     ```bash
     helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
     helm install otel-collector open-telemetry/opentelemetry-collector \
       --namespace monitoring
     ```

---
