# ---------------------------------------------------------------
library(ggplot2)

# For CSV files
muts <- read.csv("https://raw.githubusercontent.com/sgomezguti/yeast_evolution/refs/heads/main/mutations_clean.csv")

# Put the mutation types in a fixed order for the plots
muts$mutation_type <- factor(muts$mutation_type,
                             levels = c("SNP", "DEL", "INS", "SUB", "MOB"))

head(muts)                       # look at the first rows
table(muts$mutation_type)        # how many of each type

theme_set(theme_bw(base_size = 14))

# 2. FIGURE 1: number of mutations of each type -------------------
p1 <- ggplot(muts, aes(x = mutation_type, fill = mutation_type)) +
  geom_bar(show.legend = FALSE) +
  labs(x = "Mutation type", y = "Number of mutations", title = "Mutation types")
p1

# 3. FIGURE 2: mutations per chromosome, colored by type ----------
p2 <- ggplot(muts, aes(x = seq_id, fill = mutation_type)) +
  geom_bar() +
  labs(x = "Chromosome (SeqID)", y = "Number of mutations", fill = "Type",
       title = "Mutations per chromosome") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
p2

# 4. FIGURE 3: frequency histogram --------------------------------
# frequency = fraction of reads with the mutation (1 = 100%)
p3 <- ggplot(muts, aes(x = frequency, fill = mutation_type)) +
  geom_histogram(binwidth = 0.05, boundary = 0, colour = "white") +
  labs(x = "Mutation frequency", y = "Number of mutations", fill = "Type",
       title = "Mutation frequencies")
p3

# 5. FIGURE 4: SNP new base ---------------------------------------
snps <- subset(muts, mutation_type == "SNP")   # keep only SNP rows
p4 <- ggplot(snps, aes(x = new_base, fill = new_base)) +
  geom_bar(show.legend = FALSE) +
  labs(x = "New base", y = "Number of SNPs", title = "SNPs: base introduced")
p4

# 6. FIGURE 5: fixed vs. polymorphic ------------------------------
# Fixed = frequency of about 100%; polymorphic = below that
muts$status <- ifelse(muts$frequency >= 0.99, "Fixed", "Polymorphic")
p5 <- ggplot(muts, aes(x = mutation_type, fill = status)) +
  geom_bar(position = "fill") +
  labs(x = "Mutation type", y = "Proportion", fill = NULL,
       title = "Fixed vs. polymorphic mutations")
p5
