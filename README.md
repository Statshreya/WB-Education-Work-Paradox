# The Female Education-Employment Paradox 📊
### A Spatial and Econometric Analysis of West Bengal (Census 2011)

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Statistics](https://img.shields.io/badge/Statistics-Applied-green?style=for-the-badge)

## 📌 Executive Summary
In traditional economic models, higher education typically correlates with higher workforce participation. However, West Bengal presents a **structural paradox**. This project investigates why districts with the highest female literacy rates often exhibit the lowest Female Work Participation Rates (FWPR).

**The Core Finding:** For every 1% increase in female literacy, there is a **0.32% decrease** in work participation.

---

## 🚀 Key Statistical Findings

### 1. The Inverse Correlation
Using Simple Linear Regression on 19 districts, the study identifies a strong negative relationship:
- **Correlation Coefficient ($r$):** `-0.60`
- **Regression Equation:** $Y = 41.15 - 0.32X$
- **Elasticity ($E_p$):** `-1.24` (The workforce is highly sensitive/elastic to changes in education levels).

### 2. Descriptive Benchmarks
| Metric | Mean Value |
| :--- | :--- |
| **Female Literacy Rate** | 71.01% |
| **Work Participation Rate (FWPR)** | 18.43% |
| **The Gap (Literacy - Work)** | ~52.5% |

---

## 🗺️ Spatial Strategy: Quadrant Analysis
Districts were categorized into four zones based on their deviation from the mean:

* **🔴 The Paradox Zone (High Literacy, Low Work):** *Kolkata, North 24 Parganas, Haora, Nadia.* These districts suffer from "Human Capital Leakage."
* **🟡 The Survival Model (Low Literacy, High Work):** *Puruliya, Malda, Bankura.* Work is driven by economic necessity rather than educational qualification.
* **🟢 The Progressive Zone (High Literacy, High Work):** *Paschim Medinipur, Darjiling.*
* **⚪ The Stagnant Zone (Low Literacy, Low Work):** *Uttar Dinajpur.*

---

## 🛠️ Tech Stack & Methodology
- **Data Source:** Census of India (2011), Govt. of West Bengal Economic Review.
- **Data Processing:** Python (Pandas) for data cleaning and feature engineering.
- **Econometrics:** R for Simple Linear Regression and Elasticity modeling.
- **Geospatial:** Plotly/Folium for interactive choropleth mapping.

---


## 💡 Policy Recommendations
1. **Bridge the "Vocational Gap":** Shift focus from general literacy to market-linked skill development.
2. **The Murshidabad Model:** Encourage home-based cottage industries where social mobility is restricted.
3. **Urban Flexibility:** Create "Work-from-near-home" hubs in Paradox districts like Kolkata to accommodate social barriers.



