# Momo Store aka Пельменная №2

Адрес мазагина - https://dmitry-kozhemyakin.ru

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Frontend

```bash
npm install
NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run serve
```

## Backend

```bash
go run ./cmd/api
go test -v ./... 
```

## Чеклист

- Код хранится в GitLab с использованием любого git-flow
- В проекте присутствует .gitlab-ci.yml, в котором описаны шаги сборки
- Артефакты сборки публикуются в систему хранения
- Артефакты сборки версионируются
- Написаны Dockerfile'ы для сборки Docker-образов бэкенда и фронтенда
- Бэкенд: бинарный файл Go в Docker-образе
- Фронтенд: HTML-страница раздаётся с Nginx
- В GitLab CI описан шаг сборки и публикации артефактов
- В GitLab CI описан шаг тестирования
- В GitLab CI описан шаг деплоя
- Развёрнут Kubernetes-кластер в облаке
- Kubernetes-кластер описан в виде кода, и код хранится в репозитории GitLab
- Конфигурация всех необходимых ресурсов описана согласно IaC
- Состояние Terraform'а хранится в S3
- Секреты не хранятся в открытом виде
- Написан Helm-чарт для публикации приложения
- Приложение подключено к системам логирования и мониторинга
- Есть дашборд, в котором можно посмотреть логи и состояние приложения


## CI/CD

- используется единый репозиторий
- развертывание приложение осуществляется с использованием Downstream pipeline
- при изменениях в соответствующих директориях триггерятся pipeline для backend, frontend и infrastructure
- backend и frontend проходят этапы сборки, тестирования, релиза, деплоя
- артефакты выгружаются в nexus
- анализ кода выполняется через SonarQube
- helm проходит этапы релиза и деплоя
- разворачивается ingress-nginx, к которому привязан домен https://dmitry-kozhemyakin.ru

## Кластер k8s

Разворачивае кластера k8s происходит через Terraform путем деплоя через CI/CD
Джоба deploy запускается вручную
Состояние всех объектов хранится в S3
Облачный провайдер - Yandex Cloud

### Зависимости

**Terraform v. 1.5.7**

**yandex-cloud/yandex v. 0.97.0**

### Переменные
Для создания кластера нужно задать первоначальные переменные, описанные в infra \ terraform \ .gitlab-ci.yml:

| Имя | Описание |
| ------ | ------ |
| ```YC_TOKEN``` | IAM-токен облака в YC |
| ```TF_VAR_cloud_id``` | ID  облака |
| ```TF_VAR_folder_id``` | ID  папки |
| ```AWS_ACCESS_KEY_ID``` | ID сервисного пользователя для бакета |
| ```AWS_SECRET_ACCESS_KEY``` | Ключ сервисного пользователя для бакета  |    
| ```TF_VAR_cluster_name``` | Имя кластера  | 
------------
### Вывод
| Имя | Описание |
| ------ | ------ | 
| ```Cluster_IP_Adress``` | Внешний IP кластера |
| ```Cluster_ID``` | ID кластера |
| ```Cluster_Name``` | Имя кластера |
------------
После создания кластера подключаемся к нему: 

```bash
yc managed-kubernetes cluster \
   get-credentials <имя_или_идентификатор_кластера> \
   --external
```
------------
Далее убеждаемся что конфиг верный:

```bash
kubectl cluster-info
```
------------
### Удаление кластера

Для удаления кластера и всех зависимых ресурсов запускаем вручную джобу cleanup

## Мониторинг

Развернуты Grafana, Loki, Prometheus

Grafana - https://grafana.dmitry-kozhemyakin.ru/d/ytC7jEqIz/momo-store?orgId=1&refresh=10s

Prometheus - https://prometheus.dmitry-kozhemyakin.ru

