// 空的Prisma客户端实现
const emptyPrismaClient = {
  // 添加一些基本方法，避免使用时报错
  $connect: async () => console.warn('Prisma客户端已被禁用，请使用API服务获取数据'),
  $disconnect: async () => {},
  // 可以根据需要添加更多空方法
};

// 导出空客户端，以保持结构一致性
export const prismaWriter = emptyPrismaClient;
export const prismaReader = emptyPrismaClient;
export const prisma = emptyPrismaClient;

// 添加警告日志
console.warn('警告: 前端应用不应直接使用Prisma访问数据库，请使用API服务获取数据');

export default prisma;