import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "博客系统",
  description: "基于Next.js的博客系统",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  // 使用基本HTML结构，不引用任何外部字体
  return (
    <html lang="zh-CN">
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
      </head>
      <body>
        {children}
      </body>
    </html>
  );
}
