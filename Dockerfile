FROM ubuntu:24.04 AS build
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates tar clang libssl-dev && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /tmp/nolc && curl -fsSL https://noliae-nolc.s3.gra.io.cloud.ovh.net/nolc-latest-linux-x86_64.tar.gz | tar -xzf - --strip-components=1 -C /tmp/nolc
COPY . /app
WORKDIR /app
RUN /tmp/nolc/nolc nhtml views/register.nhtml && /tmp/nolc/nolc build main.nol -o app --lien ssl --lien crypto --chemin-lib /usr/lib/x86_64-linux-gnu
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y --no-install-recommends libssl3 ca-certificates && rm -rf /var/lib/apt/lists/* && useradd --system --uid 10001 noliae
COPY --from=build /app/app /app/app
COPY --from=build /app/static /app/static
USER 10001:10001
WORKDIR /app
EXPOSE 8080
CMD ["/app/app"]
