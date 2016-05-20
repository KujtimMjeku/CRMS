package com.crms.config;

import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

class Position
{
	int x;
	int y;
	int val;
	public Position(int x, int y, int val) {
		super();
		this.x = x;
		this.y = y;
		this.val = val;
	}
	@Override
	public String toString() {
		return "Position [x=" + x + ", y=" + y + ", val=" + val + "]";
	}
	
}

public class Solution {

    public static void main(String[] args) {
        Scanner sc=new Scanner(System.in);
        int W= sc.nextInt();
        int L=sc.nextInt();
        sc.nextLine();
        Position[][] bord=new Position[L][W];
        Position dera=null;
        for (int i = 0; i <L; i++) {
        	String s=sc.nextLine();
			for (int j = 0; j < W; j++) {
				if(s.charAt(j)=='x')
				{
					bord[i][j]=new Position(i, j, 1);
				}
				else if(s.charAt(j)=='.')
				{
					bord[i][j]=new Position(i, j, 2);
				}
				else if(s.charAt(j)=='/')
				{
					bord[i][j]=new Position(i, j, 3);
				}
				else if(s.charAt(j)=='\\')
				{
					bord[i][j]=new Position(i, j, 4);
				}
				else if(s.charAt(j)=='*')
				{
					dera=new Position(i, j, 5);
					bord[i][j]=bord[i][j]=dera;
				}
				//System.out.print(bord[i][j].val);
			}
			//System.out.println();
		}
        finddor(bord, dera, W, L);
    }
    public static void finddor(Position[][] bord,Position dera,int w,int h)
    {
    	Position nextPos=null;
    	int n=0;
    	if(dera.x == 0)
    	{
    		 nextPos=bord[dera.x+1][dera.y];
    		 n=2;
    		 
    	}
    	else if(dera.y==0)
    	{
    		 nextPos=bord[dera.x][dera.y+1];
    		 n=1;
    		 		
    	}
    	else if(dera.x==h)
    	{
    		 nextPos=bord[dera.x-1][dera.y];   		
    		 n=3;
    	}
    	else if(dera.y==w)
    	{
    		 nextPos=bord[dera.x][dera.y-1]; 
    		 n=4;
    		 
    	}
    	while(nextPos.val!=1)
		{
			if(nextPos.val == 2)
			{ 
				if(n==1)
				{
					nextPos=bord[nextPos.x][nextPos.y+1];
				}else if(n==2)
				{
					nextPos=bord[nextPos.x+1][nextPos.y];
				}
				else if(n==3)
				{
					nextPos=bord[nextPos.x-1][nextPos.y];
				}
				else if(n==4)
				{
					nextPos=bord[nextPos.x][nextPos.y-1];
				}
			}
			else if(nextPos.val == 3)
			{
				if(n==1)
				{
					nextPos=bord[nextPos.x-1][nextPos.y];
					n=3;
				}else if(n==2)
				{
					nextPos=bord[nextPos.x][nextPos.y-1];
					n=4;
				}
				else if(n==3)
				{
					nextPos=bord[nextPos.x][nextPos.y+1];
					n=1;
				}
				else if(n==4)
				{
					nextPos=bord[nextPos.x+1][nextPos.y];
					n=2;
				}
			}
			else if(nextPos.val == 4)
			{
				if(n==1)
				{
					nextPos=bord[nextPos.x+1][nextPos.y];
					n=2;
				}else if(n==2)
				{
					nextPos=bord[nextPos.x][nextPos.y+1];
					n=1;
				}
				else if(n==3)
				{
					nextPos=bord[nextPos.x][nextPos.y-1];
					n=4;
				}
				else if(n==4)
				{
					nextPos=bord[nextPos.x-1][nextPos.y];
					n=3;
				}
			}
		}
    	
    	for (int i = 0; i <h; i++) {
			for (int j = 0; j < w; j++) {
				if( i == nextPos.x && j==nextPos.y)
				{
					System.out.print("&");
				}
				else if(bord[i][j].val==1)
				{
					System.out.print("x");
				}
				else if(bord[i][j].val==2)
				{
					System.out.print(".");
				}
				else if(bord[i][j].val==3)
				{
					System.out.print("/");
				}
				else if(bord[i][j].val==4)
				{
					System.out.print("\\");
				}
				else  if(bord[i][j].val==5)
				{
					System.out.print("*");
				}
				//System.out.print(bord[i][j].val);
			}
			System.out.println();
		}
    }
}






