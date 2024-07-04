# Human Activity Recognition Using Smartphones Dataset

## وصف المشروع

هذا المشروع يهدف إلى جمع، تنظيف، وترتيب بيانات الأنشطة البشرية التي تم جمعها باستخدام مقاييس التسارع من هاتف Samsung Galaxy S الذكي.

## الملفات

- 'run_analysis.R': برنامج نصي يقوم بتحميل البيانات، دمجها، تنظيفها، وترتيبها.
- 'CodeBook.md': ملف يحتوي على وصف للمتغيرات والبيانات وكيفية تحويلها وتنظيفها.
- 'tidy_dataset.txt': مجموعة البيانات المُرتبة النهائية.

## كيفية تشغيل البرنامج

1. تأكد من تثبيت R والحزم المطلوبة ('dplyr' و 'data.table').
2. قم بتشغيل البرنامج النصي 'run_analysis.R باستخدام الأمر التالي في R:
   source("run_analysis.R")

تم تحميل البيانات من http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

عندها سيتم تحميل البيانات وإنشاء الملف tidy_dataset.txt الذي يحتوي على مجموعة البيانات المُرتبة.

https://github.com/zabih-aliahbabiu/Human-Activity-Recognition-Using-Smartphones
