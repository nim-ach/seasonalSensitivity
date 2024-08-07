library(seasonalSensitivity)
library(ggstatsplot)
library(ggplot2)


# Figure 1 ----------------------------------------------------------------

xlevels <- c("Low", "Moderate", "High")
fig1 <- ggstatsplot::ggbarstats(
  data = data.table::copy(dataset)[, deporte_intensidad := `levels<-`(deporte_intensidad, xlevels)][],
  x = ss_index,
  y = deporte_intensidad,
  results.subtitle = FALSE,
  caption = NULL,
  xlab = "Self-Perceived Intensity",
  legend.title = "",
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = ggplot2::theme(plot.caption = ggplot2::element_blank(),
                                    legend.position = "top")
)

tiff(filename = "manuscript/figures/fig1.TIFF", width = 5, height = 7.5, units = "in", res = 450)
print(fig1)
dev.off()

pdf(file = "manuscript/figures/fig1.pdf", width = 5, height = 7.5)
print(fig1)
dev.off()

# Figure 2 ------------------------------------------------------------------------------------

xlevels <- c("No problem", "Mild", "Moderate", "Major", "Serious", "Severe")
a <- ggstatsplot::ggbarstats(
  data = data.table::copy(dataset)[, ss_severidad := `levels<-`(ss_severidad, xlevels)][],
  x = ss_index,
  y = ss_severidad,
  results.subtitle = FALSE,
  bf.message = FALSE,
  legend.title = "",
  xlab = "Severity",
  package = "ggsci",
  palette = "default_jama"
)

xlevels <- c("Summer", "Winter", "Mixed")
b <- ggstatsplot::ggbarstats(
  data = data.table::copy(dataset)[, ss_patron_tipo := `levels<-`(ss_patron_tipo, xlevels)][],
  x = ss_index,
  y = ss_patron_tipo,
  results.subtitle = FALSE,
  bf.message = FALSE,
  legend.title = NA,
  xlab = "Pattern",
  package = "ggsci",
  palette = "default_jama"
)

fig2 <- ggpubr::ggarrange(
  plotlist = list(a, b),
  nrow = 1,
  align = "hv",
  labels = paste0(LETTERS[1:2], "."),
  common.legend = TRUE
)

tiff(filename = "manuscript/figures/fig2.TIFF", width = 10, height = 7.5, units = "in", res = 450)
print(fig2)
dev.off()

pdf(file = "manuscript/figures/fig2.pdf", width = 10, height = 7.5)
print(fig2)
dev.off()

# Figure 3 ------------------------------------------------------------------------------------

## Modificar el formato de los valores p según las recomendaciones de la
## revista. Esta función se encarga de ello automáticamente.
change_p_values <- function(df) {
  building <- ggplot_build(df)

  labels <- building$data[[7]]$annotation

  p_values <- substr(labels, 28L, nchar(labels) - 2L)
  p_values <- as.numeric(p_values)
  p_values <- paste0("italic(p) ", data.table::fifelse(
    test = p_values < 0.001,
    yes = "< 0.001",
    no = paste("==", round(p_values, 3))
  ))

  building$data[[7]]$annotation <- p_values

  plot <- ggplot_gtable(building)
  return(plot)
}


a <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_autoaceptacion,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Self-acceptance",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
) |> change_p_values()

b <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_relaciones_positivas,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Positive relationships",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
)

c <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_autonomia,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Autonomy",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
) |> change_p_values()

d <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_dominio_entorno,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Environmental control",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
) |> change_p_values()

e <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_crecimiento_personal,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Personal growth",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
) |> change_p_values()

f <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_proposito_vida,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Life purpose",
  package = "ggsci",
  palette = "default_jama",
  results.subtitle = FALSE
) |> change_p_values()

fig3 <- ggpubr::ggarrange(
  plotlist = list(a, b, c, d, e, f),
  ncol = 2, nrow = 3,
  align = "hv",
  labels = paste0(LETTERS[1:6], ".")
)

tiff(filename = "manuscript/figures/fig3.TIFF", width = 12, height = 16, units = "in", res = 450)
print(fig3)
dev.off()

pdf(file = "manuscript/figures/fig3.pdf", width = 12, height = 16)
print(fig3)
dev.off()

zip(
  zipfile = "manuscript/figures/figures.zip",
  files = list.files(
    path = "manuscript/figures/",
    pattern = "pdf$|tiff$",
    ignore.case = TRUE,
    full.names = TRUE
  )
)
