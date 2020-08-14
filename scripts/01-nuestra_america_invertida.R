# Script to generate modleR logo
library(ggplot2)
library(rgdal)
library(showtext)
library(raster)
library(rasterVis)
library(hexSticker)

# South America shapefile
shp <- readOGR("dados/shapefile/am_sul/South_America.shp")

# Creating raster from shapefile
base_ras <- raster(extent(shp), res = 1)
ras <- rasterize(shp, base_ras)*0

# Parametros mapa
# cor liibre
liibre <- "#a70000"
liibre_amarelo <- "#FFC003"
size <- 10
font_add_google("Miriam libre", "fonte")

# Latam map
map <- gplot(ras) +
  geom_tile(aes(fill = factor(value)), na.rm = TRUE, show.legend = FALSE, alpha = 1) +
  scale_fill_manual(values = liibre) +
  geom_hline(yintercept = 0, colour = liibre) + #equador
  geom_hline(yintercept = -23.4366, colour = liibre) + #tropico de capricornio +
  annotate(geom = "text",
           x = -64, y = -57, label = "S",
           family = "fonte",
           size = size,
           color = liibre) +
  theme_void()

sur <- map +
  scale_y_reverse(limits = c(13, -60)) +
  scale_x_reverse(limits = c(-20, -92))

sticker(sur,
        package = "¡liibre!",
        s_x = 1, s_y = 1.05,
        s_width = 1.7, s_height = 1.7,
        p_size = 19,
        #p_y = 1.2,# subtropico,
        p_x = 1.04,
        p_y = 0.75, # para tropicos,
        p_family = 'fonte',
        p_color = liibre_amarelo,
        h_fill = 'white',
        h_color = liibre,
        filename = paste0("figures/logo_liibre.png"))
