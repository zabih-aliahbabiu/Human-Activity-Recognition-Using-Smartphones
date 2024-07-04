#تنزيل الحزم اللازمة
#install.packages("dplyr")
#install.packages("data.table")

# تحميل الحزم اللازمة
library(dplyr)
library(data.table)

#  تحميل البيانات من الموقع وفك الضغط
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")
unzip("dataset.zip")

# قراءة البيانات من الملفات بعد فك الضغط
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityId", "activityName"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$V2)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityId")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$V2)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityId")

# دمج بيانات التدريب والاختبار لإنشاء مجموعة بيانات واحدة 
subject <- rbind(subject_train, subject_test)
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)

# دمج كل البيانات في مجموعة بيانات واحدة
merged_data <- cbind(subject, y, x)

# استخراج القياسات على المتوسط والانحراف المعياري لكل قياس
mean_std_columns <- grepl("mean|std", features$V2)
selected_columns <- c(TRUE, TRUE, mean_std_columns)
tidy_data <- merged_data[, selected_columns]

# استخدام أسماء الأنشطة الوصفية لتسمية الأنشطة في مجموعة البيانات
tidy_data <- merge(tidy_data, activity_labels, by = "activityId")

# تسمية مجموعة البيانات بشكل مناسب بأسماء المتغيرات الوصفية
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))

# إنشاء مجموعة بيانات مُرتبة ثانية بمتوسط كل متغير لكل نشاط ولكل موضوع
final_data <- tidy_data %>%
  group_by(subject, activityName) %>%
  summarise_all(funs(mean))

# حفظ مجموعة البيانات المُرتبة في ملف نصّي
write.table(final_data, "tidy_dataset.txt", row.name=FALSE)
