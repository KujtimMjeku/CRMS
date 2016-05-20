package com.crms.controller;

import java.util.Scanner;

public class Solution {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int pNumber=sc.nextInt();
		int taken=sc.nextInt();
		if(taken <= pNumber/2)
		{
			if(taken % 2==0)
			{
				System.out.print(taken-1+" ");
				int pageToCenter=pNumber/2-taken;
				System.out.print((pNumber/2+pageToCenter)+1+" ");
				System.out.print((pNumber/2+pageToCenter)+2);
			}
			else
			{
				System.out.print(taken+1+ " ");
				int pageToCenter=pNumber/2-taken;
				System.out.print((pNumber/2+pageToCenter)+" ");
				System.out.print((pNumber/2+pageToCenter)+1);
			}
		}
		else
		{
			if(taken % 2==0)
			{
				
				int pageToCenter=pNumber/2-taken;
				System.out.print((pNumber/2+pageToCenter)+1+" ");
				System.out.print((pNumber/2+pageToCenter)+2+ " ");
				System.out.print(taken-1);
			}
			else
			{
				
				int pageToCenter=pNumber/2-taken;
				System.out.print((pNumber/2+pageToCenter)+" ");
				System.out.print((pNumber/2+pageToCenter)+1+" ");
				System.out.print(taken+1);
			}
		}
	}
}