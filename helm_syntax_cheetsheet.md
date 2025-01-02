## <mark>Using **variables** within Helm templates.</mark>

* Each line demonstrates different functions and methods for handling values from the `values.yaml` file in a Helm chart.

### 1. Basic Value Reference

- **`name: {{ .Values.storageClassName }}`**
  - This simply retrieves the value of `storageClassName` from the `values.yaml` file. If `storageClassName` is defined, it will be used directly.

### 2. Quoting Values

- **`name: {{ .Values.storageClassName | quote }}`**
  - This retrieves the value of `storageClassName` and wraps it in quotes. This is useful for ensuring that the value is treated as a string, especially if it contains special characters or spaces.

### 3. Default Values

- **`name: {{ .Values.storageClassName | default "default value" }}`**
  - This retrieves `storageClassName`, but if it is not set (i.e., it is `nil`), it will use `"default value"` instead. This provides a fallback option.

### 4. Required Values

- **`name: {{ .Values.storageClassName | required ".storageClassName must be set" }}`**
  - This checks if `storageClassName` is set. If it is not, it will return an error with the specified message, preventing the chart from being installed without this critical value.

### 5. Trimming Whitespace

- **`name: {{ .Values.storageClassName | trim }}`**
  - This removes any leading or trailing whitespace from the value of `storageClassName`.

### 6. Formatted Strings

- **`name: {{ printf "%s-%d" .Values.storageClassName .Values.storageClassVersion }}`**
  - This uses the `printf` function to format a string that combines `storageClassName` and `storageClassVersion`. For example, if `storageClassName` is "fast" and `storageClassVersion` is "1", it would produce "fast-1".
	- %d ==> for integer, %s ==> for string

### 7. Replacing Placeholders

- **`name: {{ .Values.storageClassName | replace "{placeholder}" "example" }}`**	
  - This replaces occurrences of `{placeholder}` in `storageClassName` with "example". This can be useful for dynamic configurations.

### 8. Variable Assignment

- **`{{ $fullName := printf "%s %s" .Values.firstName .Values.lastName }}`**
  - This assigns a formatted string (combining first and last names) to a variable named `$fullName`, which can be used later in the template.

### 9. Trimming Specific Characters

- **`name: {{ .Values.storageClassName | trimAll "/" }}`**
  - This removes all occurrences of the character `/` from both ends of the `storageClassName`.

- **`name: {{ .Values.storageClassName | trimPrefix "/" }}`**
  - This removes a leading `/`, if present, from the beginning of `storageClassName`.

- **`name: {{ .Values.storageClassName | trimSuffix "/" }}`**
  - This removes a trailing `/`, if present, from the end of `storageClassName`.

### 10. Changing Case

- **`name: {{ .Values.storageClassName | lower }}`**
  - Converts the value of `storageClassName` to lowercase.

- **`name: {{ .Values.storageClassName | upper }}`**
  - Converts the value of `storageClassName` to uppercase.

---

## <mark>**Built-in's**</mark>

The built-in expressions you provided are part of Helm's templating capabilities, allowing you to access various contextual information about the release, chart, and files. Here’s a detailed explanation of each expression:

### 1. Release Information

- **`{{ .Release.Name }}`**:
  - This expression retrieves the name of the current Helm release. The release name is specified when you install or upgrade a chart and is used to identify that specific deployment within the Kubernetes cluster.

- **`{{ .Release.Namespace }}`**:
  - This expression fetches the namespace in which the Helm release is deployed. If no namespace is specified during installation, it defaults to the `default` namespace.

### 2. Chart Information

- **`{{ .Chart.Name }}`**:
  - This retrieves the name of the chart being deployed. The chart name is defined in the `Chart.yaml` file and represents the application or service being packaged.

- **`{{ .Chart.Version }}`**:
  - This expression gets the version of the chart being used. This version is also specified in the `Chart.yaml` file, which helps track which version of an application is deployed.

### 3. File Access

- **`{{ .Files.Get "config.ini" }}`**:
  - This expression retrieves the contents of a file named `config.ini` located in the `files/` directory of your Helm chart. The `.Files.Get` function allows you to include external configuration files directly into your templates, making it easier to manage complex configurations.

---
## <mark>**Conditionals**</mark>
```go
{{ if .Values.enablePersistence }}
  # ...
{{ else if .Values.enableFilesystem }}
  # ...
{{ else }}
  # ...
{{ end }}

# equal, not equal
{{ if eq .Values.environment "production" }}
{{ if ne .Values.environment "production" }}

# and, or
{{ if and (eq .Values.environment "production") (eq .Values.host "minikube") }}
{{ if or (eq .Values.environment "production") (eq .Values.host "minikube") }}

# not (negation)
{{ if not (eq .Values.environment "production") }}

# greater than, less than
{{ if gt (len .Values.items) 3 }}
{{ if gte (len .Values.items) 3 }}
{{ if lt (len .Values.items) 3 }}
{{ if lte (len .Values.items) 3 }}

# strings
{{ if .Values.name | contains "example" }}
{{ if .Values.name | hasPrefix "foobar-" }}
{{ if .Values.name | hasSuffix "-foobar" }}
{{ if .Values.name | regexMatch "^[a-z]+$" }}

# lists
{{ if .Values.items | has "example" }}

# ternary
{{ ternary "returned if true" "returned if false" .Values.someBoolean }}
```
---
## <mark>**Loops**</mark>

loops are used to iterate over collections such as lists (arrays) and maps (dictionaries).

### 1. Simple Loop

```yaml
volumes:
  {{ range .Values.volumeIds }}
  - volumeName: {{ . }}
  {{ end }}
```

- **Explanation**:
  - **`{{ range .Values.volumeIds }}`**: This starts a loop over the `volumeIds` array defined in your `values.yaml` file.
  - **`.`**: Inside the loop, `.` refers to the current item in the iteration. In this case, it represents each individual volume ID.
  - **`{{ end }}`**: This ends the loop.
  
- **Usage**: This is useful for generating a list of items based on an array of values. For example, if `volumeIds` contains multiple volume IDs, this loop will create a corresponding list of volumes in the output YAML.

### 2. Loop with Named Variable

```yaml
volumes:
  {{ range $volumeId := .Values.volumeIds }}
  - volumeName: {{ $volumeId }}
  {{ end }}
```

- **Explanation**:
  - **`{{ range $volumeId := .Values.volumeIds }}`**: This starts a loop similar to the previous example but uses a named variable `$volumeId` to refer to the current item in the iteration.
  - **`{{ $volumeId }}`**: This explicitly references the named variable instead of using `.`.
  
- **Usage**: This approach is beneficial when you want to make your code more readable or when you need to use the variable multiple times within the loop.

### 3. Loop with Index (Array) or Key (Dict)

```yaml
volumes:
  {{ range $key, $value := .Values.configuration }}
  - {{ $key }}: {{ $value }}
  {{ end }}
```

- **Explanation**:
  - **`{{ range $key, $value := .Values.configuration }}`**: This starts a loop over a map (dictionary) called `configuration`. Here, `$key` represents each key in the map, and `$value` represents the corresponding value.
  - **`{{ $key }}` and `{{ $value }}`**: These are used to output the key-value pairs from the map.
  
- **Usage**: This is useful for generating key-value pairs in your YAML output when working with dictionaries. For example, if `configuration` contains settings for your application, this loop will create entries for each configuration setting.

### Example Values File

To illustrate how these loops work, here’s an example `values.yaml` file that could be used with the above templates:

```yaml
volumeIds:
  - volume1
  - volume2
  - volume3

configuration:
  setting1: value1
  setting2: value2
```

### Example Rendered Output

Using the above values file with your loops would yield:

```yaml
volumes:
  - volumeName: volume1
  - volumeName: volume2
  - volumeName: volume3

# For configuration output
setting1: value1
setting2: value2
```
---

## <mark>**Indentation**</mark>

### 1. Using `toYaml` with `indent`

```yaml
env:
  {{ .Values.environmentVariables | toYaml | indent 2 }}
```

- **`toYaml`**: This function converts a given data structure (like a map or list) into a YAML-formatted string. However, it does not automatically adjust the indentation of the output relative to its context.
- **`indent 2`**: This function adds two spaces of indentation to each line of the output from `toYaml`. This is useful when you want to ensure that the generated YAML is properly nested under the `env:` key.

**Output Example**:
If `environmentVariables` contains:
```yaml
environmentVariables:
  VAR1: value1
  VAR2: value2
```

The rendered output will be:
```yaml
env:
    VAR1: value1
    VAR2: value2
```

### 2. Using `toYaml` with `nindent`

```yaml
env: {{ .Values.environmentVariables | toYaml | nindent 2 }}
```

- **`nindent 2`**: Similar to `indent`, but it also ensures that the first line of the output starts on a new line. This is particularly useful when you want to avoid any potential issues with inline content or when the preceding line ends with content.

**Output Example**:
Using the same `environmentVariables`, the rendered output will be:
```yaml
env:
  VAR1: value1
  VAR2: value2
```
---


---
## <mark>**Includes**</mark>

[Refer Here](https://helm-playground.com/cheatsheet.html) for syntax.

Let's assume some example values in the `values.yaml` file and demonstrate how the templates would work with the given definitions.

---

### **Example `values.yaml`**
```yaml
image:
  name: my-app
  tag: v1.2.3

foobar: "This is a {placeholder} string."
```

---

### **Templates**
1. **`your-project.image`**
   ```yaml
   {{- define "your-project.image" -}}
   {{ printf "%s:%s" .Values.image.name .Values.image.tag | quote }}
   {{- end -}}
   ```

2. **`your-project.someInclude`**
   ```yaml
   {{- define "your-project.someInclude" -}}
   {{ . | replace "{placeholder}" "example" }}
   {{- end -}}
   ```

---

### **Rendered YAML Output**

1. **For `image` Field**  
   If you use the following in your deployment file:

   ```yaml
   image: {{ include "your-project.image" . }}
   ```

   With the given `values.yaml`, the output will be:

   ```yaml
   image: "my-app:v1.2.3"
   ```

2. **For `foobar` Field**  
   If you use the following in your deployment file:

   ```yaml
   foobar: {{ include "your-project.someInclude" .Values.foobar }}
   ```

   With the given `values.yaml`, the output will be:

   ```yaml
   foobar: "This is a example string."
   ```

---

### **Full Rendered Output Example**

Combining both templates in a deployment file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
spec:
  template:
    spec:
      containers:
        - name: example-container
          image: {{ include "your-project.image" . }}
          env:
            - name: EXAMPLE_FOOBAR
              value: {{ include "your-project.someInclude" .Values.foobar }}
```

After rendering with Helm, the output would look like this:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
spec:
  template:
    spec:
      containers:
        - name: example-container
          image: "my-app:v1.2.3"
          env:
            - name: EXAMPLE_FOOBAR
              value: "This is a example string."
```

This showcases how reusable templates can simplify and streamline your Helm charts.

You're absolutely correct that you **could directly write** something like this:

```yaml
image: {{ printf "%s:%s" .Values.image.name .Values.image.tag | quote }}
```

This is valid and would work perfectly. However, there are **several reasons** why defining reusable templates (like in `_helpers.tpl`) is often a better approach in Helm charts:


### **Summary**
- Use reusable templates when logic is complex or shared across multiple places for better **maintainability**, **readability**, and **consistency**.
- Use inline expressions for **one-off, simple cases**.

If you're creating production-grade Helm charts or working in a team, reusable templates in `_helpers.tpl` are generally the better choice.

---

Let me break this down more simply. This code decides **where the value of `foobarPassword` should come from** for a Kubernetes Secret. There are **three possible options** in order of priority:

---
## <mark>**Lookup**</mark>

### **[Explanation of Lookup code](https://helm-playground.com/cheatsheet.html#lookup)**

1. **Check if the Secret Already Exists**
   ```yaml
   {{ $previous := lookup "v1" "Secret" .Release.Namespace "some-secret" }}
   ```
   - `lookup` checks if a Kubernetes Secret named `some-secret` exists in the same namespace as your Helm release.
   - If it exists, its data is saved in `$previous`. If it doesn’t exist, `$previous` is empty (`null`).

---

2. **Decide Where `foobarPassword` Comes From**
   The code checks these conditions **in order**:

   #### **Option 1: Use an Existing Secret**
   ```yaml
   {{- if $previous }}
   foobarPassword: {{ $previous.data.foobarPassword | quote }}
   ```
   - If the Secret (`$previous`) exists:
     - Use the `foobarPassword` already stored in the Secret.
     - This prevents overwriting an existing password.

   **Example:** If the `some-secret` exists and already has:
   ```yaml
   data:
     foobarPassword: "existingPassword"
   ```
   The code will reuse `"existingPassword"`.

---

   #### **Option 2: Use a User-Provided Password**
   ```yaml
   {{- else if .Values.foobarPassword }}
   foobarPassword: {{ .Values.foobarPassword | b64enc | quote }}
   ```
   - If the Secret doesn’t exist **but** the user has provided a password in `values.yaml` (e.g., `foobarPassword: myPassword`):
     - Take the password from `.Values.foobarPassword`.
     - Encode it using `b64enc` (required for Kubernetes Secrets) and use it.

   **Example:** If `values.yaml` contains:
   ```yaml
   foobarPassword: "myUserPassword"
   ```
   The output will look like this:
   ```yaml
   foobarPassword: "bXlVc2VyUGFzc3dvcmQ="
   ```
   (This is `myUserPassword` in base64.)

---

   #### **Option 3: Generate a Random Password**
   ```yaml
   {{- else }}
   foobarPassword: {{ randAlphaNum 40 | b64enc | quote }}
   ```
   - If there’s no existing Secret and no password in `values.yaml`:
     - Generate a random password with 40 alphanumeric characters.
     - Encode it with `b64enc` and use it.

   **Example:** The generated password might look like this:
   ```yaml
   foobarPassword: "YWJjMTIzNDU2Nzg5MHJhbmRvbVBhc3M="
   ```
   (The actual value will vary each time because it’s random.)

---

### **Why This Logic is Useful**
- **Reusing Existing Data:** If a Secret already exists, it keeps the same password instead of overwriting it.
- **User Customization:** If a user wants a specific password, they can set it in `values.yaml`.
- **Fallback Security:** If neither of the above exists, it ensures a strong random password is always created.

---

### **Example Outputs**

Here’s how the rendered YAML will look in different scenarios:

#### **Scenario 1: Existing Secret**
If the Kubernetes Secret `some-secret` exists and has:
```yaml
data:
  foobarPassword: "existingPassword"
```

The rendered Secret will reuse the password:
```yaml
data:
  foobarPassword: "existingPassword"
```

---

#### **Scenario 2: Password in `values.yaml`**
If the user specifies a password in `values.yaml`:
```yaml
foobarPassword: "myUserPassword"
```

The rendered Secret will use the user-provided password:
```yaml
data:
  foobarPassword: "bXlVc2VyUGFzc3dvcmQ="
```

---

#### **Scenario 3: No Existing Secret or User-Provided Password**
If there’s no existing Secret and no `foobarPassword` in `values.yaml`, the password will be randomly generated:
```yaml
data:
  foobarPassword: "YWJjMTIzNDU2Nzg5MHJhbmRvbVBhc3M="
```

---

## <mark>**Fail**</mark>
```go
{{ if eq .Values.storageClassName "foobar1" }}
  # ...
{{ else if eq .Values.storageClassName "foobar2" }}
  # ...
{{ else }}
  {{ fail ".storageClassName is not recognized" }}
{{ end }}
```

* **`{{ fail ".storageClassName is not recognized" }}`**:
   - If none of the conditions are satisfied, this line will execute. The `fail` function causes Helm to terminate the rendering process and return an error message.
   - The message `".storageClassName is not recognized"` provides feedback indicating that an unrecognized value was provided for `storageClassName`.

---
## <mark>**Dates**</mark>

```go
{{ now | date "2006-01-02T15:04:05" }}
```

- **`now`**: This function retrieves the current date and time.
- **`date "2006-01-02T15:04:05"`**: This formats the current date and time according to the specified layout. In Go templates, the layout must be defined using a specific reference date (`2006-01-02T15:04:05`), which is a unique way of defining formats in Go.

---
## <mark>**Base64**</mark>
```go
{{ .Values.someData | b64enc }}
{{ .Values.someData | b64dec }}
```

* This expression takes the value of someData from the **values.yaml** file and **encodes** it in **Base64** format using the **b64enc function**.

---

## <mark>**UUIDs**</mark>
```go
id: {{ uuidv4 }}
```

* **{{ uuidv4 }}**:
  * This function call generates a new **UUID version 4**. 
  * **UUIDs** are **128-bit numbers** used to **uniquely identify information** in computer systems.
  * **Version 4 UUIDs** are **randomly** generated, making them suitable for use as **unique identifiers** in various applications

---

## <mark>**Crypto**</mark>

```go
{{ .Values.someData | sha256sum }}

{{ .Values.someData | encryptAES "secret key" }}
{{ .Values.someData | decryptAES "secret key" }}
```

### 1. SHA256 Hashing

```yaml
id: {{ .Values.someData | sha256sum }}
```

- **Purpose**: This expression takes the value of `someData` from the `values.yaml` file and computes its SHA256 hash using the `sha256sum` function.

### 2. AES Encryption

```yaml
{{ .Values.someData | encryptAES "secret key" }}
```

- **Purpose**: This expression encrypts the value of `someData` using AES (Advanced Encryption Standard) with the provided `"secret key"`.

### 3. AES Decryption

```yaml
{{ .Values.someData | decryptAES "secret key" }}
```

- **Purpose**: This expression decrypts a previously encrypted string using AES with the provided `"secret key"`.

---

## <mark>**useful Helm commands along with their descriptions**</mark>



| Command                                       | Description                                                                                      | Flags/Options                                                                                                 | Example                                                    |
|-----------------------------------------------|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| `helm install <release> <chart>`             | Install a chart and create a new release.                                                      | `--namespace <namespace>`, `--values <file>`, `--set <key=value>`, `--timeout <duration>`, `--wait`, `--atomic`, `--create-namespace` | `helm install my-release stable/mysql --namespace my-namespace` |
| `helm upgrade <release> <chart>`             | Upgrade a release to a new version of a chart or modify its configuration.                     | `--install`, `--values <file>`, `--set <key=value>`, `--timeout <duration>`, `--wait`, `--no-hooks`        | `helm upgrade my-release stable/mysql --set mysqlRootPassword=newpassword` |
| `helm rollback <release> [revision]`        | Roll back a release to a previous version.                                                     | None                                                                                                         | `helm rollback my-release 1`                              |
| **`helm uninstall <release>`**                | Delete a release and free up the resources associated with it.                                 | `--namespace <namespace>`                                                                                    | `helm uninstall my-release --namespace my-namespace`      |
| **`helm list`**                               | List all the installed releases.                                                                | `--all`, `--uninstalled`, `--max <number>`, `--filter <regex>`                                            | `helm list --all`                                        |
| **`helm status <release>`**                   | Get the status of a release, including last deployment time, namespace, state, and resources.  | `--revision=<revision>`, `--show-desc=false`, `--show-resources=false`, `-o, --output=<format>`           | `helm status my-release --show-desc=true`                |
| **`helm search repo <keyword>`**              | Search for available charts in Helm repositories.                                              | None                                                                                                         | `helm search repo mysql`                                  |
| **`helm repo add <name> <url>`**             | Add a Helm repository to your local environment.                                               | None                                                                                                         | `helm repo add stable https://charts.helm.sh/stable`     |
| **`helm repo update`**                        | Update the local cache of Helm repositories.                                                   | None                                                                                                         | `helm repo update`                                       |
| **`helm lint <chart>`**                       | Lint a chart to validate its syntax and configuration.                                         | None                                                                                                         | `helm lint my-chart`                                     |
| **`helm package <chart>`**                    | Package a chart directory into a compressed chart archive.                                     | None                                                                                                         | `helm package my-chart`                                   |
| **`helm pull <chart>`**                       | Download a chart and extract the archive’s contents into a directory.                          | `--untar`, `--untardir <directory>`                                                                         | `helm pull stable/mysql --untar --untardir ./mydir`     |
| **`helm history <release>`**                  | View the release history of a chart.                                                           | None                                                                                                         | `helm history my-release`                                 |
| **`helm show chart <chart>`**                 | Display information about a specific chart.                                                    | None                                                                                                         | `helm show chart stable/mysql`                            |
| **`helm get all <release>`**                  | Download all information about a release.                                                      | None                                                                                                         | `helm get all my-release`                                 |
| **`helm get values <release>`**               | Download the values file for a release.                                                        | None                                                                                                         | `helm get values my-release`                              |
| **Helpful Options for Install/Upgrade/Rollback**  | **Description**                                                                                  | **Example**                                                                                                |
| **`--timeout <duration>`**                    | Duration to wait for Kubernetes commands to complete (default is 5m0s).                        | Example: 5m, 10s                                                                                            |
| **`--wait`**                                  | Wait until all Pods are in a ready state before marking the release as successful.             | Use with install or upgrade commands                                                                         |
| **Set Values**                                | Set multiple values at once using comma separation.                                             | Example:  --set key1=value1,key2=value2                                                                     |

---

## <mark>**override specific values in a Helm chart**</mark>

### 1. Using the `--set` Flag

For quick and simple overrides, you can use the `--set` flag directly from the command line. This is ideal for making small adjustments without modifying a values file.

**Example Command:**

```bash
helm install my-nginx bitnami/nginx --set replicaCount=3
```

You can also set multiple values at once by separating them with commas:

```bash
helm install my-nginx bitnami/nginx --set replicaCount=3,service.type=NodePort
```

### 2. Using a Custom `values.yaml` File

For more complex configurations, it's better to create a separate `values.yaml` file where you define all your overrides in one place. This method helps keep your changes organized and maintainable.

**Example Custom Values File (`custom-values.yaml`):**

```yaml
replicaCount: 3
service:
  type: LoadBalancer
  port: 8080
```

**Deploying with Custom Values:**

```bash
helm install my-nginx bitnami/nginx -f custom-values.yaml
```

### 3. Combining `--set` with a Custom Values File

You can combine both methods for maximum flexibility. For instance, you might have a base `values.yaml` file but need to override a single value dynamically during deployment.

**Example Command:**

```bash
helm install my-nginx bitnami/nginx -f custom-values.yaml --set service.port=8081
```

This command will apply all settings from `custom-values.yaml`, but override the `service.port` value.

### 4. Checking Effective Values

After installing or upgrading a release, you can check which values are currently in effect using:

```bash
helm get values my-nginx
```

This command will show all the values being used for the release, including any custom overrides applied.
