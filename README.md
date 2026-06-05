# Camel_Kaoto

# 🔀 Apache Camel Kaoto — Multi-Route Integration Demo

> A visual Apache Camel integration project built with **Kaoto** (VS Code), **JBang**, and **ActiveMQ**, demonstrating a multi-route order processing pipeline using core Enterprise Integration Patterns.

---

## 🎨 What is Kaoto?
 
**Kaoto** is a visual, no-code / low-code editor for Apache Camel routes, built as a VS Code extension and backed by Red Hat. It is the officially recommended graphical designer for Apache Camel, allowing developers to build, visualize, and run integration flows without writing YAML or XML from scratch.
 
> *"Kaoto is a no-code / low-code editor for Apache Camel integrations. Using Kaoto will lower the barrier for integration developers to get started with Apache Camel."* — KaotoIO GitHub
 
### 🔧 What Kaoto Does
 
| Feature | Description |
|---|---|
| **Visual Canvas** | Drag-and-drop interface to design Camel routes with components, EIPs, and connectors |
| **YAML / XML DSL Sync** | Every visual change on the canvas instantly reflects in the underlying YAML or XML source, and vice versa |
| **Component Catalog** | Built-in browsable catalog of all Apache Camel components (500+), Kamelets, and EIP patterns |
| **DataMapper** | Graphical data mapping tool supporting XML and JSON schema transformations without writing code |
| **Beans Management** | Define and configure Java beans directly from the canvas for custom logic and AggregationStrategies |
| **Run & Debug** | Run, pause, stop, and monitor integrations directly from VS Code using JBang — no Maven project needed |
| **Multi-DSL Support** | Supports both YAML DSL and XML IO DSL for route authoring |
| **Kamelet Support** | Design and use Kamelets (reusable Camel route snippets) visually |
| **Export as Markdown** | Export integration flows as Markdown documents with visual diagrams for documentation and review |
| **OpenShift Integration** | Supports deployment to OpenShift and Kubernetes environments directly from the editor |
| **Auto-completion & Forms** | Smart configuration forms with auto-completion for all component parameters |
| **Version Management** | Choose specific Apache Camel versions (upstream and downstream/LTS) from within the editor |
 
---
 
## ⚖️ Kaoto (Visual / JBang) vs Apache Camel with Spring Boot (Coding)
 
This is the most important architectural decision when starting a Camel project.
 
### Apache Camel with Spring Boot (Traditional Approach)
 
In the traditional approach, you write Camel routes in **Java DSL** inside a Spring Boot application:
 
```java
@Component
public class OrderRoute extends RouteBuilder {
    @Override
    public void configure() throws Exception {
        from("timer:orderTimer?period=10000")
            .setBody(constant("<orders>...</orders>"))
            .split(xpath("//order"))
                .to("activemq:queue:orders.inbound")
            .end();
    }
}
```
 
You need:
- A full Maven/Gradle project
- `spring-boot-starter`, `camel-spring-boot-starter` dependencies
- `application.yml` / `application.properties` for configuration
- A main class with `@SpringBootApplication`
- JVM startup overhead (~5-15 seconds)
### Kaoto with JBang (Modern Lightweight Approach)
 
With Kaoto + JBang, the same route lives in a `.camel.yaml` file:
 
```yaml
- route:
    id: route-order-generator
    from:
      uri: timer
      parameters:
        timerName: orderTimer
        period: "10000"
      steps:
        - setBody:
            expression:
              constant:
                expression: "<orders>...</orders>"
        - split:
            expression:
              xpath:
                expression: "//order"
            steps:
              - to:
                  uri: "activemq:queue:orders.inbound"
```
 
No Maven project. No Spring Boot boilerplate. Just a YAML file and JBang.
 
### Comparison Table
 
| Aspect | Kaoto + JBang | Spring Boot + Java DSL |
|---|---|---|
| **Setup time** | Minutes (just install JBang + extension) | Hours (Maven project, dependencies, config) |
| **Boilerplate** | Zero | High (`@SpringBootApplication`, `RouteBuilder`, etc.) |
| **Visual design** | ✅ Full drag-and-drop canvas | ❌ Code only |
| **Hot reload** | ✅ Instant (`--dev` mode) | ⚠️ Requires Spring DevTools |
| **Production ready** | ⚠️ Export to Spring Boot / Quarkus for production | ✅ Production-grade out of the box |
| **Custom Java logic** | ⚠️ Via beans (limited) | ✅ Full Java power |
| **Debugging** | ⚠️ Log-based | ✅ Full IDE debugger support |
| **Team onboarding** | ✅ Easy (visual, no Java needed) | ⚠️ Requires Java/Spring knowledge |
| **Complex business logic** | ⚠️ Harder without Java code | ✅ Write any Java logic inline |
| **Dependency management** | Auto-downloaded by JBang | Full Maven/Gradle control |
| **Enterprise deployments** | Export to Spring Boot/Quarkus | Native Spring Boot deployment |
 
### When to Use Kaoto + JBang
- Rapid prototyping and proof-of-concept
- Lightweight integrations that don't need a full Spring Boot app
- Teams with non-Java developers (analysts, integration specialists)
- Learning Apache Camel quickly
- Scripting and automation workflows
### When to Use Spring Boot + Java DSL
- Production enterprise applications
- Complex business logic requiring full Java code
- Existing Spring Boot ecosystems
- Applications needing Spring Security, Spring Data, etc.
- Microservices requiring embedded servers
> 💡 **Best of both worlds:** Kaoto is not either/or. You can prototype in Kaoto visually, then **export** the route to a Spring Boot or Quarkus project using `jbang camel@apache/camel export --runtime=spring-boot` — keeping the visual design and adding Java power for production.
 
---
 
## ✅ Advantages of Kaoto
 
- **Zero boilerplate** — No Maven project, no Spring Boot setup, no main class needed
- **Visual-first development** — See the integration flow as you build it, making complex routes easier to understand and communicate
- **Instant feedback** — `--dev` mode hot-reloads routes on every save without restarting
- **Lower barrier to entry** — Non-Java developers can build integrations using the visual canvas
- **Built-in component catalog** — Browse and configure 500+ Camel components without memorizing URIs
- **DataMapper** — Visual XML/JSON schema mapping replaces hand-written XSLT in many cases
- **Documentation export** — Export routes as Markdown with visual diagrams for team sharing
- **Open source & vendor-neutral** — No lock-in; backed by Red Hat, fully Apache licensed
- **Integrated lifecycle** — Design, run, pause, stop, and deploy all from VS Code
---
 
## ❌ Disadvantages of Kaoto
 
- **Limited custom Java logic** — Complex business logic that needs full Java classes is harder to implement; must be done via registered beans
- **YAML DSL constraints** — Some Camel features available in Java DSL are not fully expressible in YAML DSL (e.g., inline Processors, anonymous AggregationStrategies)
- **No Spring ecosystem** — Can't directly use Spring Security, Spring Data, or Spring beans without exporting to a Spring Boot project
- **Path/classpath issues** — Resource files (XSLT, schemas) require careful path configuration (`file:` prefix vs classpath)
- **JBang dependency** — Requires JBang installed and on PATH; VS Code tasks use login shells which can miss PATH entries from `.zshrc`
- **Early maturity** — Still evolving; some advanced features like message tracing and test integration are roadmap items
- **Space in folder names** — Folder names with spaces cause URL encoding issues in resource URIs (e.g., `Camel%20Kaoto`)
- **Not production-ready standalone** — For serious production deployments, you still need to export to Spring Boot or Quarkus
---
 
## 🔩 How `.process()` Works in Kaoto
 
In Apache Camel's **Java DSL** with Spring Boot, you implement custom message processing using the `Processor` interface:
 
```java
// Java DSL — Traditional Spring Boot approach
from("activemq:queue:orders.inbound")
    .process(exchange -> {
        String body = exchange.getIn().getBody(String.class);
        exchange.getIn().setBody("<processed>" + body + "</processed>");
        exchange.getIn().setHeader("processed", true);
    })
    .to("activemq:queue:orders.processed");
```
 
**In Kaoto (YAML DSL), there is no inline `.process()`.** Custom processing logic is handled in two ways:
 
### Option 1 — Register a Processor as a Bean
 
Define the Processor class and register it in the `- beans:` section:
 
```yaml
- beans:
    - name: myProcessor
      type: com.example.MyOrderProcessor   # Your Java class implementing Processor
 
- route:
    id: route-item-enricher
    from:
      uri: "activemq:queue:orders.inbound"
      steps:
        - process:
            ref: myProcessor               # Reference the registered bean
        - to:
            uri: "activemq:queue:orders.processed"
```
 
Your Java class:
```java
public class MyOrderProcessor implements Processor {
    @Override
    public void process(Exchange exchange) throws Exception {
        String body = exchange.getIn().getBody(String.class);
        exchange.getIn().setBody("<processed>" + body + "</processed>");
        exchange.getIn().setHeader("processed", true);
    }
}
```
 
### Option 2 — Use Built-in EIP Steps Instead
 
Kaoto encourages replacing custom processors with **built-in EIP steps** where possible:
 
| Java DSL `.process()` use case | Kaoto YAML equivalent |
|---|---|
| Modify message body | `setBody` with Simple/Groovy expression |
| Add/modify headers | `setHeader` / `setHeaders` |
| Content-based routing | `choice` / `when` / `otherwise` |
| Data transformation | `xslt`, DataMapper, `marshal`/`unmarshal` |
| Enriching from external source | `enrich` / `pollEnrich` |
| Logging | `log` with `${body}`, `${headers}` |
 
### Option 3 — Use the `script` Step
 
For lightweight inline logic without a full Java class:
 
```yaml
- script:
    groovy:
      expression: "exchange.in.body = '<processed>' + exchange.in.body + '</processed>'"
```
 
Supported languages: `groovy`, `js` (JavaScript), `python`, `ruby`.
 
---


# Demo integration flow using Yaml DSL in Camel kaoto

## 📁 Project Structure

```
Camel_Kaoto/
├── demo.camel.yaml     # Main route definitions (3 routes)
├── enrich.xslt         # XSLT transformation template
├── output/             # Generated order files (git-ignored)
└── .gitignore
```

---

## 🔄 The Integration Flow

This project implements a **multi-route order processing pipeline** using three core Enterprise Integration Patterns:

```
┌──────────────────────────────────────────────────────────┐
│                  ROUTE 1: Order Generator                │
│                                                          │
│  Timer (10s) ──► SetBody (XML orders) ──► Split by order │
│                                               │          │
│                                               ▼          │
│                                  ActiveMQ: orders.inbound│
└──────────────────────────────────────────────────────────┘
                               │
                               ▼
┌──────────────────────────────────────────────────────────┐
│                  ROUTE 2: Item Enricher                  │
│                                                          │
│  ActiveMQ: orders.inbound ──► XSLT Transform            │
│                            ──► SetHeader (orderStatus)  │
│                            ──► Log                      │
│                            ──► ActiveMQ: orders.processed│
└──────────────────────────────────────────────────────────┘
                               │
                               ▼
┌──────────────────────────────────────────────────────────┐
│                  ROUTE 3: Aggregator                     │
│                                                          │
│  ActiveMQ: orders.processed ──► Aggregate (batch of 3)  │
│                              ──► Log                    │
│                              ──► File (output/*.xml)    │
└──────────────────────────────────────────────────────────┘
```

---

## 🗂️ Route Details

### Route 1 — Order Generator
- A **Timer** triggers every 10 seconds
- **SetBody** produces a mock XML payload containing 3 orders (Laptop, Mouse, Keyboard)
- The **Splitter EIP** splits the XML by `//order` XPath expression, sending each order individually to the `orders.inbound` ActiveMQ queue

### Route 2 — Item Enricher
- Consumes each order from `orders.inbound`
- Applies an **XSLT transformation** (`enrich.xslt`) to restructure the XML into a `<processedOrder>` format
- Sets an `orderStatus` header with value `PROCESSED` using the **Content Enricher EIP**
- Logs the enriched message and forwards to the `orders.processed` queue

### Route 3 — Aggregator
- Consumes processed orders from `orders.processed`
- The **Aggregator EIP** collects messages using a fixed correlation key (`all-orders`) and completes when **3 messages** are gathered
- Logs the aggregated batch and writes it to a timestamped XML file in the `output/` directory

---

## 📐 Enterprise Integration Patterns Used

| Pattern | Where Used |
|---|---|
| **Splitter** | Route 1 — splits XML orders into individual messages |
| **Content Enricher** | Route 2 — adds status header to each order |
| **Aggregator** | Route 3 — collects 3 orders into a single batch |
| **Message Channel** | ActiveMQ queues connecting all three routes |
| **Message Transformation** | XSLT converting raw order XML to processed format |

---

## 🔁 XSLT Transformation

The `enrich.xslt` transforms each raw order item:

**Input:**
```xml
<order>
  <id>1</id>
  <item>Laptop</item>
  <qty>2</qty>
</order>
```

**Output:**
```xml
<processedOrder>
  <id>1</id>
  <item>Laptop</item>
  <qty>2</qty>
  <status>ENRICHED</status>
</processedOrder>
```

---

## 🚀 How to Run

**1. Install JBang**
```bash
curl -Ls https://sh.jbang.dev | bash -s - app setup
echo 'export PATH="$HOME/.jbang/bin:$PATH"' >> ~/.zprofile
source ~/.zprofile
```

**2. Trust Apache Camel scripts**
```bash
jbang trust add https://github.com/apache/
```

**3. Start ActiveMQ**
```bash
activemq start
```

**4. Run the integration**
```bash
jbang '-Dcamel.jbang.version=4.13.0' camel@apache/camel run demo.camel.yaml --dev --logging-level=info
```

Or simply open `demo.camel.yaml` in VS Code with Kaoto and click **▶ Run Integration**.

---
