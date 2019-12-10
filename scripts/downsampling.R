library(ggplot2)


# read in data
downsampled <- read.csv("bulk_downsampled_counts.txt", header = T, row.names =1 , sep = "\t")

# get binary expressed, not expressed
downsampled <- downsampled > 0 

#extract bulk RNA-seq sample
bulk <- downsampled[, colnames(downsampled) == "ERR522956", drop=FALSE]
downsampled <- downsampled[, colnames(downsampled) != "ERR522956", drop=FALSE]

#read in gene/isoform table
gene_iso_relationships <- read.csv("unfiltered_gencode_M20_gene_iso_relationships.txt", header = FALSE, sep = " ",
                                   row.names = NULL)

genes_list <- unique(gene_iso_relationships$V1)



get_overlap <- function(genes_list, gene_iso_relationship, bulk, downsampled, string){
  
  df<-data.frame(data=character(), gene = character(), mean_overlap = numeric())
  
  for (gene in genes_list){
    #get isoforms
    isoforms <- gene_iso_relationships[gene_iso_relationships$V1 == gene, ]$V2
    
    expressed_isoforms <- bulk[rownames(bulk) %in% isoforms,,drop = FALSE]
    expressed_isoforms <- rownames(expressed_isoforms[expressed_isoforms==TRUE,, drop=FALSE])
    
    if (length(expressed_isoforms) == 4){
      downsampled_isoforms <- downsampled[rownames(downsampled) %in% expressed_isoforms,, drop=FALSE]
      overlap<-mean(apply(downsampled_isoforms, 2, function(x) sum(x) / length(expressed_isoforms) )) # find mean overlap for each gene
      local <- data.frame(data = c(string), gene = c(gene), mean_overlap = c(overlap))
      df <- rbind(df,local)
    } else {
      next
    }
  }
  return(df)
}

downsampled_overlap <- get_overlap(genes_list, gene_iso_relationships, bulk, downsampled, "downsampled")

single_cell <- read.csv("E-MTAB-2600-standard_2i.txt", header = T, row.names =1 , sep = "\t")
single_cell <- single_cell[, colnames(single_cell)!="ERR522956"]
single_cell <- single_cell > 0 

single_cell_overlap <- get_overlap(genes_list, gene_iso_relationships, bulk, single_cell,"single cell")

overlap_df <- rbind(downsampled_overlap, single_cell_overlap)
                          
                          
ggplot(data = overlap_df, aes(x = Data, y = mean_overlap, fill=Data)) + ylab("Mean Overlap") + xlab("Data") + geom_boxplot() + geom_jitter( size = 0.5) + theme(text = element_text(size=20))
ggsave("Downsampling_results.png", plot = last_plot())
