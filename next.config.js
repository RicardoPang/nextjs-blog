/** @type {import('next').NextConfig} */
const nextConfig = {
  // 允许远程图片源
  images: {
    remotePatterns: [
      { protocol: 'https', hostname: 'randomuser.me' },
      { protocol: 'https', hostname: 'www.postgresql.org' },
      { protocol: 'https', hostname: 'nextjs.org' },
      { protocol: 'https', hostname: 'example.com' },
      { protocol: 'https', hostname: 'picsum.photos' },
      { protocol: 'https', hostname: 'd2f3o3rd6akggk.cloudfront.net' }
    ],
  },
  // 禁用构建时的ESLint检查
  eslint: {
    ignoreDuringBuilds: true,
  },
};

module.exports = nextConfig;
