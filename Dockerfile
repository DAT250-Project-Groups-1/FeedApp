FROM cirrusci/flutter AS build

RUN flutter channel dev
RUN flutter upgrade
RUN flutter config --enable-web

WORKDIR /app
COPY /app/pubspec.yaml .
RUN flutter pub get
COPY /app .
RUN flutter build web --dart-define=API_URL=""

FROM golang:alpine

WORKDIR /build

COPY api/go.mod .
COPY api/go.sum .
RUN go mod download

COPY api .

RUN go build -o main .

WORKDIR /dist

#ENV GOOGLE_APPLICATION_CREDENTIALS=/build/service_account.json

RUN cp /build/main .
COPY --from=build /app/build/web ./static

EXPOSE 8080

CMD ["/dist/main"]                