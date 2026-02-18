# 1. التغيير لـ bookworm لحل مشكلة الـ 404 (أهم خطوة)
FROM python:3.10-slim-bookworm

# 2. تحديث وتثبيت الأدوات في سطر واحد لتقليل حجم النسخة
RUN apt update && apt upgrade -y && \
    apt install git curl ffmpeg -y

# 3. إعداد مجلد العمل أولاً قبل نسخ أي ملفات (ترتيب أنظف)
WORKDIR /app

# 4. نسخ الـ requirements وتثبيتها
COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -U -r requirements.txt

# نسخ باقي ملفات المشروع للمجلد الحالي
COPY . .

# تجهيز ملف التشغيل
RUN chmod +x startup.sh

# تشغيل البوت
CMD ["/bin/bash", "startup.sh"]
