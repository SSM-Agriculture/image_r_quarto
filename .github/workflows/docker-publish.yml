# Base image R avec système Debian stable
FROM rocker/r-ver:4.5.1

# Installer dépendances système utiles (y compris pour quarto et LaTeX PDF si besoin)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    gdebi-core \
    pandoc \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    zlib1g-dev \
    fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

# Installer Quarto CLI (via .deb)
ENV QUARTO_VERSION=1.4.550
RUN wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb && \
    gdebi --non-interactive quarto-${QUARTO_VERSION}-linux-amd64.deb && \
    rm quarto-${QUARTO_VERSION}-linux-amd64.deb

# Installer quelques packages R utiles
RUN install2.r --error --skipinstalled \
    tidyverse \
    quarto \
    rmarkdown

# Vérification
RUN Rscript -e 'sessionInfo()' && quarto --version

CMD ["R"]
