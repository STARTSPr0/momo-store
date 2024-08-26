# Momo Store aka Пельменная №2

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

## Кластер k8s

Разворачивае кластера k8s происходит через Terraform путем деплоя через CI/CD. Состояние всех объектов хранится в S3. Облачный провайдер - Yandex Cloud

Для создания кластера нужно задать первоначальные параметры, описанные в infra \ terraform \ .gitlab-ci.yml:

| Имя | Описание |
| ------ | ------ |
| YC_TOKEN | IAM-токен облака в YC |
| TF_VAR_cloud_id | ID  облака |
| TF_VAR_folder_id | ID  папки |
| AWS_ACCESS_KEY_ID | ID сервисного пользователя для бакета |
| AWS_SECRET_ACCESS_KEY | Ключ сервисного пользователя для бакета  |    
| TF_VAR_cluster_name | Имя кластера  | 