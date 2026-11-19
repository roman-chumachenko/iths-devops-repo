# Observability

## Base conception
**Observability** is the ability to infer the internal state of a system solely from its external outputs, without requiring a redeployment or manual SSH/console access to debug issues. Unlike traditional monitoring, which answers *"Is the system working?"* based on predefined metrics and thresholds, observability answers *"Why is the system behaving this way right now?"*.

The foundation of observability rests on the **Three Pillars of Observability**:

1. **Logs** - structured records of discrete events within an application (for example, JSON logs containing severity levels like `INFO`/`ERROR`, timestamps, request context, and error codes).
2. **Metrics** - numerical measurements of system health and performance over time (CPU, memory consumption, RPS, p95/p99 latency, HTTP 5xx error counts) used for dashboards and alerting.
3. **Traces (Distributed Tracing)** - the end-to-end journey of a single request across multiple services and dependencies (tracked via `TraceId` and `SpanId`), pinpointing the exact stage where a bottleneck or failure occurred.

Within the **Azure** ecosystem, centralized telemetry collection and analysis are powered by:
* **Azure Monitor** - a unified platform for collecting telemetry, metrics, and configuring alerts.
* **Log Analytics Workspace** - a centralized log repository powered by **KQL (Kusto Query Language)** for filtering, aggregation, and incident investigation.
* **Application Insights** - an APM (Application Performance Management) service for tracking requests, dependencies, exceptions, Live Metrics, and distributed service topologies (Application Map).

---

## Before and after
### Before (Without Observability)
* **Blind operations ("black box"):** the team only learns about outages or performance degradation after end users report issues.
* **Lack of centralization:** logs are scattered across individual containers or local files and are lost whenever instances restart or scale down.
* **Unstructured output:** plain-text `console.log` statements lacking context (`requestId`, release version, HTTP status), making automated filtering and analysis difficult.
* **Slow troubleshooting (high MTTR):** it is hard to quickly determine whether an error stems from an application bug, slow database queries, or network timeouts.
* **No proactive alerting:** no automated notifications when error rates spike or service availability drops.

### After (With Observability)
* **Single pane of glass:** all logs, metrics, and traces automatically flow into **Log Analytics Workspace** and **Application Insights**.
* **Structured telemetry:** every request carries rich metadata (application version, commit SHA, execution duration, HTTP status), making it easy to correlate errors with a specific deployment.
* **Fast root-cause analysis via KQL:** errors can be filtered, latency trends visualized, and bottlenecks isolated within seconds.
* **Proactive alerts and health checks:** the platform continuously monitors the `/health` endpoint and key metrics, alerting the team before issues impact the majority of users.
* **Data-driven releases and rollbacks:** combined with CI/CD and revisions, observability provides objective signals for safe gradual rollouts (canary/traffic splitting) and immediate rollback decisions.
