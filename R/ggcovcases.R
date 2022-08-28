# Function call
utils::globalVariables(c(
    "Cumulative_cases",
    "Cumulative_deaths",
    "Date_labels",
    "Date_reported",
    "New_cases",
    "New_deaths",
    "Sevendays_average_new_cases",
    "Sevendays_average_new_deaths",
    "date_breaks date_format"
))

#' Get specific country's COVID-19 cases and deaths from WHO COVID-19 Global Data.
#'
#' @param country_name target country for data visualisation, default "The United Kingdom".
#' @param days date duration, default 90.
#'
#' @importFrom ggplot2 ggplot
#' @importFrom utils read.csv tail
#' @export
#'
get_country_cases_data <- function(country_name = "The United Kingdom", days = 90) {
    data_imported <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv")
    data_country  <- data_imported[data_imported$Country == country_name, ]
    data_country  <- tail(data_country, n = days)
    data_country$Date_reported <- as.POSIXct(data_country$Date_reported)
    data_country <- transform(
        data_country,
        Sevendays_average_new_cases = as.integer(filter(data_country$New_cases, c(1, 1, 1, 1, 1, 1, 1)) / 7))
    data_country <- transform(
        data_country,
        Sevendays_average_new_deaths = as.integer(filter(data_country$New_deaths, c(1, 1, 1, 1, 1, 1, 1)) / 7))
    return(data_country)
}

#' Visualise specific country's COVID-19 new cases from WHO COVID-19 Global Data.
#' 
#' @param country_name target country of data visualisation, default "The United Kingdom".
#' @param days date duration, default 90.
#' @param axis_x_txt_size size of X axis text, default 8.
#' @param line_size_cases   size of cases line, default 1.0.
#' @param line_size_average size of 7 days average line, default 2.0.
#' @param line_colour_cases colour of cases line, default "gray".
#' @param line_colour_average colour of 7 days average line, "#3EC70B".
#'
#' @importFrom stats filter
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme_light
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 scale_x_datetime
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_blank
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ylab
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 scale_color_manual
#' @importFrom ggplot2 element_text
#' @importFrom scales comma
#' @importFrom scales date_format
#' @importFrom scales date_breaks
#' @export
#'
plot_country_new_cases <- function(
    country_name = "The United Kingdom",
    days = 90,
    axis_x_txt_size = 8,
    line_size_cases = 1.,
    line_size_average = 2.,
    line_colour_cases = "gray",
    line_colour_average = "#3EC70B") {
    data_imported <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv")
    data_country  <- data_imported[data_imported$Country == country_name, ]
    data_country  <- tail(data_country, n = days)
    data_country$Date_reported <- as.POSIXct(data_country$Date_reported)
    data_country <- transform(data_country, Sevendays_average_new_cases = as.numeric(filter(data_country$New_cases, c(1, 1, 1, 1, 1, 1, 1)) / 7))

    plot <- ggplot(data = data_country, aes(x = Date_reported)) +
        theme_light() +
        scale_y_continuous(labels = scales::comma, limits = c(0, max(data_country$New_cases))) +
        scale_x_datetime(labels = date_format("%d/%m %Y"), breaks = date_breaks("7 days")) +
        theme(
            text        = element_text(family = "mono"),
            axis.text.x = element_text(angle = 60, hjust = 1, family = "mono", size = axis_x_txt_size ),
            axis.text.y = element_text(family = "mono"),
            panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank()) +
        xlab("Date") +
        ylab("New cases") +
        ggtitle(paste("Lineplot of COVID-19 new cases in", country_name, "\nfor the latest", days, "days.")) +
        geom_line(aes(y = New_cases, colour = "New cases"), size = line_size_cases) +
        geom_line(aes(y = Sevendays_average_new_cases, colour = "7 days average"), size = line_size_average) +
        scale_color_manual(
            name = "",
            values = c( "New cases" = line_colour_cases, "7 days average" = line_colour_average))

    return(plot)
}

#' Visualise specific country's COVID-19 cumulative cases from WHO COVID-19 Global Data.
#' 
#' @param country_name target country of data visualisation, default "The United Kingdom".
#' @param days date duration, default 90.
#' @param axis_x_txt_size size of X axis text, default 8.
#' @param line_size size of line, default 2.0,
#' @param line_colour colour of line, default "#3EC70B".
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme_light
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 scale_x_datetime
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ylab
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 scale_color_manual
#' @importFrom ggplot2 element_text
#' @importFrom scales comma
#' @importFrom scales date_format
#' @importFrom scales date_breaks
#' @export
#'
plot_country_cumulative_cases <- function(
    country_name = "The United Kingdom",
    days = 90,
    axis_x_txt_size = 8,
    line_size = 2.,
    line_colour = "#3EC70B") {
    data_imported <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv")
    data_country  <- data_imported[data_imported$Country == country_name, ]
    data_country  <- tail(data_country, n = days)
    data_country$Date_reported <- as.POSIXct(data_country$Date_reported)

    plot <- ggplot(data = data_country, aes(x = Date_reported)) +
        theme_light() +
        scale_y_continuous(labels = scales::comma, limits = c(0, max( data_country$Cumulative_cases))) +
        scale_x_datetime(labels = date_format("%d/%m %Y"), breaks = date_breaks("7 days")) +
        theme(
            text        = element_text(family = "mono"),
            axis.text.x = element_text(angle = 60, hjust = 1, family = "mono", size = axis_x_txt_size),
            axis.text.y = element_text(family = "mono"),
            panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank()) +
        ggtitle(paste("Lineplot of COVID-19 cumulative cases in", country_name, "\nfor the latest", days, "days.")) +
        xlab("Date") +
        ylab("Cumulative cases") +
        geom_line(aes(y = Cumulative_cases, colour = "Cumulative\ncases"), size = line_size) +
        scale_color_manual(name = "", values = c("Cumulative\ncases" = line_colour))

    return(plot)
}

#' Visualise specific country's COVID-19 new deaths from WHO COVID-19 Global Data.
#' 
#' @param country_name target country of data visualisation, default "The United Kingdom".
#' @param days date duration, default 90.
#' @param axis_x_txt_size size of X axis text, default 8.
#' @param line_size_deaths size of deaths line, default 1.0.
#' @param line_size_average size of 7 days average line, default 2.0.
#' @param line_colour_deaths colour of deaths line, default "gray".
#' @param line_colour_average colour of 7 days average line, "#3EC70B".
#'
#' @importFrom stats filter
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme_light
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 scale_x_datetime
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ylab
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 scale_color_manual
#' @importFrom ggplot2 element_text
#' @importFrom scales comma
#' @importFrom scales date_format
#' @importFrom scales date_breaks
#' @export
#'
plot_country_new_deaths <- function(
    country_name = "The United Kingdom",
    days = 90,
    axis_x_txt_size = 8,
    line_size_deaths = 1.,
    line_size_average = 2.,
    line_colour_deaths = "gray",
    line_colour_average = "#3EC70B") {
    data_imported <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv")
    data_country  <- data_imported[data_imported$Country == country_name, ]
    data_country  <- tail(data_country, n = days)
    data_country$Date_reported <- as.POSIXct(data_country$Date_reported)
    data_country <- transform(data_country, Sevendays_average_new_deaths = as.numeric(filter(data_country$New_deaths, c(1, 1, 1, 1, 1, 1, 1)) / 7))

    plot <- ggplot(data = data_country, aes(x = Date_reported)) +
        theme_light() +
        scale_y_continuous(labels = scales::comma, limits = c(0, max(data_country$New_deaths))) +
        scale_x_datetime(labels = date_format("%d/%m %Y"), breaks = date_breaks("7 days")) +
        theme(
            text        = element_text(family = "mono"),
            axis.text.x = element_text(angle = 60, hjust = 1, family = "mono", size = axis_x_txt_size),
            axis.text.y = element_text(family = "mono"),
            panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank()) +
        xlab("Date") +
        ylab("New deaths") +
        ggtitle(paste("Lineplot of COVID-19 new deaths in", country_name, "\nfor the latest", days, "days.")) +
        geom_line(aes(y = New_deaths,                   colour = "New deaths"), size = line_size_deaths) +
        geom_line(aes(y = Sevendays_average_new_deaths, colour = "7 days average"), size = line_size_average) +
        scale_color_manual(name = "", values = c( "New deaths" = line_colour_deaths, "7 days average" = line_colour_average))

    return(plot)
}

#' Visualise specific country's COVID-19 cumulative deaths from WHO COVID-19 Global Data.
#' 
#' @param country_name target country of data visualisation, default "The United Kingdom".
#' @param days date duration, default 90.
#' @param axis_x_txt_size size of X axis text, default 8.
#' @param line_size size of line, default 2.0,
#' @param line_colour colour of line, default "#3EC70B".
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme_light
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 scale_x_datetime
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ylab
#' @importFrom ggplot2 geom_line
#' @importFrom ggplot2 scale_color_manual
#' @importFrom ggplot2 element_text
#' @importFrom scales comma
#' @importFrom scales date_format
#' @importFrom scales date_breaks
#' @export
#'
plot_country_cumulative_deaths <- function(
    country_name = "The United Kingdom",
    days = 90,
    axis_x_txt_size = 8,
    line_size = 2.,
    line_colour = "#3EC70B") {
    data_imported <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv")
    data_country  <- data_imported[data_imported$Country == country_name, ]
    data_country  <- tail(data_country, n = days)
    data_country$Date_reported <- as.POSIXct(data_country$Date_reported)

    plot <- ggplot(data = data_country, aes(x = Date_reported)) +
        theme_light() +
        scale_y_continuous(labels = scales::comma, limits = c(0, max(data_country$Cumulative_deaths))) +
        scale_x_datetime(labels = date_format("%d/%m %Y"), breaks = date_breaks("7 days")) +
        theme(
            text        = element_text(family = "mono"),
            axis.text.x = element_text(angle = 60, hjust = 1, family = "mono", size = axis_x_txt_size),
            axis.text.y = element_text(family = "mono"),
            panel.grid.major.x = element_blank(),
            panel.grid.minor.x = element_blank()) +
        ggtitle(paste("Lineplot of COVID-19 cumulative deaths in", country_name, "\nfor the latest", days, "days.")) +
        xlab("Date") +
        ylab("Cumulative deaths") +
        geom_line(aes(y = Cumulative_deaths, colour = "Cumulative\ndeaths"), size = line_size) +
        scale_color_manual(name = "", values = c("Cumulative\ndeaths" = line_colour))

    return(plot)
}

#' Visualise specific country's relationships between cases and deaths using connected scatter plot.
#'
#' @param country_name target country of data visualisation, default "The United Kingdom".
#' @param days date duration, default 90.
#' @param axis_x_txt_size size of X axis text, default 8.
#' @param segment_size segment size of connected scatter plot, default 0.02.
#' @param segment_colour segment colour of connected scatter plot, default "gray".
#' @param point_size point size of connected scatter plot, default 2.0.
#' @param point_colour point colour of connected scatter plot, default "#3EC70B".
#' @param label_size label size of connected scatter plot, default 2.0.
#' @param label_colour label colour of connected scatter plot, default "#3EC70B".
#'
#' @importFrom stats filter
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme_light
#' @importFrom ggplot2 scale_y_continuous
#' @importFrom ggplot2 scale_x_continuous
#' @importFrom ggplot2 scale_x_datetime
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 xlab
#' @importFrom ggplot2 ylab
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 geom_segment
#' @importFrom ggplot2 geom_label
#' @importFrom ggplot2 arrow
#' @importFrom ggplot2 unit
#' @importFrom ggplot2 scale_color_manual
#' @importFrom ggplot2 element_text
#' @importFrom scales comma
#' @export
#'
plot_country_new_cases_deaths <- function(
    country_name = "The United Kingdom",
    days = 90,
    axis_x_txt_size = 8,
    segment_size = .02,
    segment_colour = "gray",
    point_size = 2.,
    point_colour = "#3EC70B",
    label_size = 2.,
    label_colour = "#3EC70B") {
    data_imported <- read.csv("https://covid19.who.int/WHO-COVID-19-global-data.csv")
    data_country  <- data_imported[data_imported$Country == country_name, ]
    data_country  <- tail(data_country, n = days)

    data_labels <- rep(NA, length(data_country$Date_reported))
    for (i in 1:length(data_country$Date_reported)) {
        if (i %% 7 == 0) {
            data_labels[i] <- data_country$Date_reported[i]
        }
    }
    data_country <- transform(data_country, Date_labels = data_labels)

    data_country$Date_reported <- as.POSIXct(data_country$Date_reported)
    data_country <- transform(
        data_country,
        Sevendays_average_new_cases = as.numeric(filter(data_country$New_cases, c(1, 1, 1, 1, 1, 1, 1)) / 7))

    plot <- ggplot(
        data = data_country,
        aes(x = New_cases, y = New_deaths, label = Date_labels)) +
        theme_light() +
        scale_x_continuous(
            labels = scales::comma,
            limits = c(0, max(data_country$New_cases))) +
        scale_y_continuous(
            labels = scales::comma,
            limits = c(0, max(data_country$New_deaths))) +
        theme(
            text        = element_text(family = "mono"),
            axis.text.x = element_text(angle = 60, hjust = 1, family = "mono", size = axis_x_txt_size),
            axis.text.y = element_text(family = "mono")) +
        xlab("New cases") +
        ylab("New deaths") +
        ggtitle(paste(
            "Connected scatter plot of COVID-19 new cases and new deaths in",
            country_name, "\nfor the latest", days, "days.")) +
        geom_segment(
            aes(
                xend = c(tail(New_cases, n = -1), NA),
                yend = c(tail(New_deaths, n = -1), NA)),
            colour = segment_colour,
            arrow = arrow(length = unit(segment_size, "npc"),
            type = "closed")) +
        geom_point(colour = point_colour, size = point_size) +
        geom_label(colour = label_colour, size = label_size, family = "mono")

    return(plot)
}
