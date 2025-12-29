#Necessary Libraries
library(readxl)
library(ggplot2)  
library(dplyr)    
library(ggpubr)
install.packages("ggpubr")
#Data import
df <- read_excel("C:\\Users\\shrey\\OneDrive\\Desktop\\WB_Female_Literacy_Work_Analysis.xlsx")
df
str(df)
summary(df[, c("Female_Literacy_Rate", "FWPR")])

# 1. Clean the data
df_clean <- na.omit(df)

# 2. Check the difference in size
print(paste("Original rows:", nrow(df)))
print(paste("Cleaned rows:", nrow(df_clean)))

# 3. Verify there are 0 NAs left
sum(is.na(df_clean)) 

# 4. See the new summary
summary(df_clean$Female_Literacy_Rate)
summary(df_clean$FWPR)




#Box-plot Analysis
ggplot(df_clean, aes(x = TRU, y = FWPR, fill = TRU)) + 
  geom_boxplot() + 
  labs(title = "Work Participation Gap: Rural vs Urban")


# Filter for Urban and find the highest FWPR
urban_outliers <- df_clean %>% 
  filter(TRU == "Urban") %>% 
  arrange(desc(FWPR))

# Show the top 5
head(urban_outliers)

df_comparison <- df_clean %>% filter(TRU %in% c("Rural", "Urban"))

library(ggrepel)

ggplot(df_comparison, aes(x = TRU, y = FWPR, fill = TRU)) + 
  geom_boxplot(outlier.shape = NA) + # Hide the default dot
  geom_jitter(width = 0.1, alpha = 0.5) + # Show all districts as small dots
  geom_text_repel(data = subset(df_comparison, FWPR > 25), 
                  aes(label = AreaName), 
                  box.padding = 0.5) +
  labs(title = "Identifying the Outlier in Urban West Bengal",
       subtitle = "Murshidabad stands out significantly",
       y = "FWPR (%)")

# Filter for Rural and find the highest FWPR
rural_outliers <- df_clean %>% 
  filter(TRU == "Rural") %>% 
  arrange(desc(FWPR))

# Show the top 5
head(rural_outliers)

# We use df_total because we want the overall district picture
df_total <- df_clean %>% filter(TRU == "Total")

# 1. Calculate Correlation
cor_res <- cor.test(df_total$Female_Literacy_Rate, df_total$FWPR)
print(cor_res)

library(ggplot2)
library(ggpubr) # For adding stats to the plot automatically

# 1. Filter for Total rows and remove NAs
df_total <- na.omit(df[df$TRU == "Total", ])

# 2. Create the Scatter Plot
ggplot(df_total, aes(x = Female_Literacy_Rate, y = FWPR)) +
  geom_point(color = "darkblue", size = 3, alpha = 0.7) + # The data points
  geom_smooth(method = "lm", color = "red", fill = "pink", se = TRUE) + # Regression Line
  stat_cor(method = "pearson", label.x = 75, label.y = 30) + # Automatically displays R and P
  geom_text(aes(label = AreaName), vjust = -1, size = 3, check_overlap = TRUE) + # District names
  labs(title = "The Education-Work Paradox in West Bengal",
       subtitle = "Significant Negative Correlation (p < 0.01)",
       x = "Female Literacy Rate (%)",
       y = "Female Work Participation Rate (%)",
       caption = "Source: Census of India") +
  theme_minimal()


# Fit the linear model
final_model <- lm(FWPR ~ Female_Literacy_Rate, data = df_total)
final_model

# View the mathematical results
summary(final_model)




# Calculate means for the lines
m_lit <- mean(df_total$Female_Literacy_Rate)
m_work <- mean(df_total$FWPR)

ggplot(df_total, aes(x = Female_Literacy_Rate, y = FWPR)) +
  geom_vline(xintercept = m_lit, linetype = "dashed", color = "grey50") +
  geom_hline(yintercept = m_work, linetype = "dashed", color = "grey50") +
  geom_point(aes(color = FWPR > m_work), size = 4) +
  geom_text(aes(label = AreaName), vjust = -1, size = 3, check_overlap = TRUE) +
  annotate("label", x = 80, y = 30, label = "Progressive Zone", fill = "lightgreen") +
  annotate("label", x = 55, y = 30, label = "Traditional/Agrarian", fill = "gold") +
  annotate("label", x = 80, y = 12, label = "The Education Paradox", fill = "pink") +
  annotate("label", x = 55, y = 12, label = "Stagnant Zone", fill = "lightgrey") +
  labs(title = "District Classification: Literacy vs. Work",
       x = "Literacy Rate (%)", y = "Work Participation (%)") +
  theme_minimal() + theme(legend.position = "none")






library(tidyr)
# Prepare data for "Long" format
df_gap <- df_total %>%
  select(AreaName, Female_Literacy_Rate, FWPR) %>%
  pivot_longer(cols = c(Female_Literacy_Rate, FWPR), names_to = "Metric", values_to = "Value")

ggplot(df_gap, aes(x = reorder(AreaName, Value), y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  coord_flip() + # Makes it easier to read district names
  scale_fill_manual(values = c("Female_Literacy_Rate" = "#2c7bb6", "FWPR" = "#d7191c"),
                    labels = c("Literacy", "Work")) +
  labs(title = "The Gap: Education vs. Reality",
       x = "District", y = "Percentage (%)") +
  theme_bw()









# 1. Calculate the means of our variables
mean_lit <- mean(df_total$Female_Literacy_Rate, na.rm = TRUE)
mean_work <- mean(df_total$FWPR, na.rm = TRUE)

# 2. Extract the slope (beta coefficient) from your regression model
# This grabs the value -0.3226 automatically
slope <- coef(final_model)["Female_Literacy_Rate"]

# 3. Calculate Elasticity
# Formula: Slope * (Mean X / Mean Y)
elasticity_val <- slope * (mean_lit / mean_work)

# 4. Print the result
cat("The calculated Literacy-Work Elasticity is:", round(elasticity_val, 4), "\n")































