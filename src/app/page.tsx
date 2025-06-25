import Link from 'next/link';

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="max-w-2xl mx-auto text-center px-6">
        <div className="mb-8">
          <h1 className="text-5xl font-bold text-gray-900 mb-4">
            欢迎来到我的博客
          </h1>
          <p className="text-xl text-gray-600 mb-8">
            这里分享技术心得、学习笔记和开发经验
          </p>
        </div>
        
        <div className="space-y-6">
          <Link 
            href="/blog"
            className="inline-block bg-blue-600 text-white px-8 py-4 rounded-lg text-lg font-semibold hover:bg-blue-700 transition-colors shadow-lg hover:shadow-xl transform hover:-translate-y-1"
          >
            进入博客 →
          </Link>
          
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-12">
            <div className="bg-white p-6 rounded-lg shadow-md">
              <div className="text-blue-600 text-2xl mb-3">📝</div>
              <h3 className="font-semibold text-gray-900 mb-2">技术文章</h3>
              <p className="text-gray-600 text-sm">分享前端、后端开发经验</p>
            </div>
            
            <div className="bg-white p-6 rounded-lg shadow-md">
              <div className="text-green-600 text-2xl mb-3">💡</div>
              <h3 className="font-semibold text-gray-900 mb-2">学习笔记</h3>
              <p className="text-gray-600 text-sm">记录学习过程和心得体会</p>
            </div>
            
            <div className="bg-white p-6 rounded-lg shadow-md">
              <div className="text-purple-600 text-2xl mb-3">🚀</div>
              <h3 className="font-semibold text-gray-900 mb-2">项目分享</h3>
              <p className="text-gray-600 text-sm">展示有趣的项目和代码</p>
            </div>
          </div>
        </div>
        
        <div className="mt-12 text-gray-500 text-sm">
          使用 Next.js + TypeScript + Tailwind CSS 构建
        </div>
      </div>
    </div>
  );
}
