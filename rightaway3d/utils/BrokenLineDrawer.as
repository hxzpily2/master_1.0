package rightaway3d.utils
{
	import flash.display.Graphics;
	import flash.geom.Point;

	public class BrokenLineDrawer
	{
		/**
		 * 画虚线
		 * @param graphics：画板
		 * @param p0：起始点
		 * @param p1：结束点
		 * @param lineWidth：线宽
		 * @param lineColor：颜色
		 * @param length：线段长度
		 * @param gap：线段间距
		 * @param autoLength：自动调整线段长度，使虚线首尾能绘制完整线段
		 * 
		 */
		public static function draw(graphics:Graphics,p0:Point,p1:Point,lineWidth:uint=1,lineColor:uint=0,length:Number=2,gap:Number=2,autoLength:Boolean=true):void  
		{   
			graphics.lineStyle(lineWidth,lineColor);
			draw2(graphics,p0,p1,length,gap,autoLength);
		}
		
		/**
		 * 画虚线
		 * @param graphics：画板
		 * @param p0：起始点
		 * @param p1：结束点
		 * @param length：线段长度
		 * @param gap：线段间距
		 * @param autoLength：自动调整线段长度，使虚线首尾能绘制完整线段
		 * 
		 */
		public static function draw2(graphics:Graphics,p0:Point,p1:Point,length:Number=2,gap:Number=2,autoLength:Boolean=true):void  
		{   
			var max:Number = Point.distance(p0,p1);
			
			var n:int = (max+gap)/(length+gap);
			if(n<2)
			{
				length = max;//如果不能完整绘制两条以上线段，则绘制一整条直线
			}
			else if(autoLength)
			{
				length = (max+gap)/n - gap;//调整线段长度，使其正好绘制于虚线首尾
			}
			
			var step:Number = 0;
			
			var tp0:Point;   
			var tp1:Point;
			
			while(step<max)   
			{   
				tp0 = Point.interpolate(p1,p0,step/max);
				
				step+=length;
				
				if(step>max)step=max;
				
				tp1 = Point.interpolate(p1,p0,step/max);
				
				graphics.moveTo(tp0.x,tp0.y);
				graphics.lineTo(tp1.x,tp1.y);
				
				step+=gap;   
			}   
		}
	}
}