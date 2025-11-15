# AWS Terraform Infrastructure Project

## Опис
Цей проект автоматично створює AWS інфраструктуру за допомогою Terraform:
- Security Group з відкритими портами (80, 443)
- EC2 інстанс з Ubuntu та Nginx
- S3 backend для збереження стейту
- Модульна структура: окремі модулі для network та ec2
- Автоматичний вибір VPC, Subnet, AMI через data sources

## Структура проекту
```
terraform/
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── data.tf
│       ├── variables.tf
│       ├── locals.tf
│       └── dev.tfvars
├── modules/
│   ├── network/
│   │   ├── variables.tf
│   │   ├── security_group.tf
│   │   └── outputs.tf
│   └── ec2/
│       ├── variables.tf
│       ├── ec2.tf
│       ├── outputs.tf
│       └── templates/
│           └── user-data.sh
└── terraform-init.sh
```

## Запуск

## Налаштування AWS користувача
1. Створіть IAM користувача з ім'ям `sk-terraform-user`. **📋 Детальні інструкції**: [create-terraform-user.md](docs/create-terraform-user.md)
2. Згенеруйте для нього Access Key та Secret Key (**📋 Налаштування credentials**: [aws-credentials-setup.md](docs/aws-credentials-setup.md)).
3. Додайте користувачу такі права:
   - `AmazonEC2FullAccess`
   - Кастомна політика `S3AccessOnlyToSvitlanaKizilpinarBucket` ([детальніше про EC2 політики](docs/add-ec2-permissions.md)).
4. Не створюйте новий S3 bucket! Використовуйте вже наданий bucket: `terraform-state-danit10-devops` (region: eu-central-1).

## Запуск
1. Перейдіть у папку середовища:
   ```bash
   cd terraform/environments/dev
   ```
2. Запустіть скрипт:
   ```bash
   bash ../../terraform-init.sh dev apply
   ```
3. Перевірте створений EC2 та доступ до Nginx через public IP.

## S3 Backend
Для збереження стейту використовується S3 bucket (налаштування у terraform.tf).

## Автоматичний вибір ресурсів
Всі ID VPC, Subnet, AMI підтягуються автоматично через data sources у data.tf.

## Змінні
Всі змінні для середовища зберігаються у dev.tfvars.

## Модулі
- network: створює security group
- ec2: створює EC2 інстанс з Nginx

## Видалення ресурсів
Для видалення інфраструктури використовуйте:
```bash
bash ../../terraform-init.sh dev destroy
```

## Результати виконання
Нижче наведені скріншоти, що демонструють успішне створення інфраструктури та доступ до Nginx:

| №     | Опис                          | Скриншот                                                      |
|-------|-------------------------------|---------------------------------------------------------------|
| 6.1   | EC2 інстанс у AWS Console     | ![EC2](Screens/6.1_aws_ec2.png)                               |
| 6.2   | Security Group для EC2        | ![EC2 SG](Screens/6.2_aws_ec2_sg.png)                         |
| 6.3   | Правила Security Group        | ![SG Rules](Screens/6.3_aws_sg.png)                           |
| 6.4   | Доступ до Nginx через браузер | ![Nginx](Screens/6.4_browser_nginx.png)                       |
| 6.5.1 | S3 bucket для Terraform state | ![Bucket](Screens/6.5.1_bucket.png)                           |
| 6.5.2 | Створена папка в bucket       | ![Folder](Screens/6.5.2_created_folder_in_bucket.png)         |
| 6.5.3 | Папка dev для середовища      | ![Dev Folder](Screens/6.5.3_created_folder_dev_in_bucket.png) |
| 6.5.4 | Файл стейту sk-dev.tfstate    | ![State File](Screens/6.5.4_created_sk_dev_tfstate.png)       |

## Корисні посилання
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Documentation](https://www.terraform.io/docs/)
- [AWS Free Tier](https://aws.amazon.com/free/)

### Додаткова документація
- [IAM User Creation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
- [How to Attach Policies to IAM User](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_manage-attach-detach.html)
- [AmazonEC2FullAccess Policy](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)
- [Terraform S3 Backend](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
