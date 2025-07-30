FROM rocker/r-ver:4.5.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl gdebi-core libcurl4-openssl-dev libssl-dev libxml2-dev zlib1g-dev git pandoc fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*

ENV QUARTO_VERSION=1.4.550
RUN wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.deb && \
    gdebi --non-interactive quarto-${QUARTO_VERSION}-linux-amd64.deb && \
    rm quarto-${QUARTO_VERSION}-linux-amd64.deb

RUN Rscript -e "install.packages('tinytex', repos = 'https://cloud.r-project.org')"

RUN curl -sL "https://yihui.org/tinytex/install-bin-unix.sh" | sh

ENV PATH="/root/.TinyTeX/bin/x86_64-linux:${PATH}"

RUN tlmgr update --self --all
RUN tlmgr install xetex latex-bin latex-xcolor collection-xetex

RUN install2.r --error --skipinstalled tidyverse rmarkdown quarto

RUN quarto --version && Rscript -e "tinytex::is_tinytex()" && which pdflatex && which xelatex

CMD ["R"]
