# ---------------------------------------------------------------
library(ggplot2)

# For CSV files
snps <- read.csv("https://raw.githubusercontent.com/sgomezguti/yeast_evolution/refs/heads/main/snps_clean.csv")

snps$snp_type <- factor(snps$snp_type,
                        levels = c("synonymous", "nonsynonymous", "nonsense", "intergenic"))

table(snps$snp_type)             # how many SNPs of each type

# Keep only the two types we want to compare
coding <- subset(snps, snp_type %in% c("synonymous", "nonsynonymous"))

theme_set(theme_bw(base_size = 14))
cols <- c(synonymous = "#4daf4a", nonsynonymous = "#e41a1c",
          nonsense = "#984ea3", intergenic = "grey60")

# 2. FIGURE A: how many synonymous vs. nonsynonymous SNPs ---------
pA <- ggplot(coding, aes(x = snp_type, fill = snp_type)) +
  geom_bar(show.legend = FALSE, width = 0.6) +
  scale_fill_manual(values = cols) +
  labs(x = NULL, y = "Number of SNPs", title = "Syn. vs. nonsyn. SNPs")
pA

# 3. FIGURE B: frequency of each type (boxplot) -------------------
pB <- ggplot(coding, aes(x = snp_type, y = frequency, fill = snp_type)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.5, show.legend = FALSE) +
  geom_jitter(width = 0.15, alpha = 0.4, show.legend = FALSE) +
  scale_fill_manual(values = cols) +
  labs(x = NULL, y = "Mutation frequency", title = "SNP frequency by type")
pB

# 4. FIGURE C: frequency histograms, one panel per type -----------
pC <- ggplot(coding, aes(x = frequency, fill = snp_type)) +
  geom_histogram(binwidth = 0.05, boundary = 0, colour = "white", show.legend = FALSE) +
  facet_wrap(~ snp_type, ncol = 1) +
  scale_fill_manual(values = cols) +
  labs(x = "Mutation frequency", y = "Number of SNPs", title = "Frequency distribution")
pC

# 5. FIGURE D: all four SNP categories ----------------------------
pD <- ggplot(snps, aes(x = snp_type, fill = snp_type)) +
  geom_bar(show.legend = FALSE) +
  scale_fill_manual(values = cols) +
  labs(x = NULL, y = "Number of SNPs", title = "All SNP categories")
pD
