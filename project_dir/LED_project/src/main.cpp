#include <FastLED.h>
#define LED_PIN     7
#define LED_PIN2     2
#define NUM_LEDS    280
#define LED_COL_MAX  255
CRGB leds[NUM_LEDS];
CRGB leds2[NUM_LEDS];

void setup();
void ClearLeds();
void LedDisolve(int AmountValue =2);
void Show1();
void Show2();
void Show3();
void Show4();
void Show5();
void Show6();
void RotateStep();
void Show5b();
int LedBounds(int);
void setup()
{
	FastLED.addLeds<WS2812, LED_PIN, GRB>(leds, NUM_LEDS);
    FastLED.addLeds<WS2812, LED_PIN2, GRB>(leds2, NUM_LEDS);
	for(int I=0;I<NUM_LEDS;I++)
	{
		leds2[I]=CRGB(255
		,255,255);
		if(I%10) leds2[I]=CRGB(0,5,0);
	};
}
int LedBounds(int LedValue)
{
	if(LedValue > NUM_LEDS) LedValue = (LedValue - NUM_LEDS);
	if(LedValue < 0) LedValue = NUM_LEDS + LedValue;
	return LedValue;
}
void RotateStep()
{
		CRGB Temp = leds[NUM_LEDS-1];
		for(int i=NUM_LEDS-1; i>0; i--)
		{
			leds[i]=leds[i-1];
		}
		leds[0] = Temp;
}
void RotateStep2()
{
		CRGB Temp = leds2[NUM_LEDS-1];
		for(int i=NUM_LEDS-1; i>0; i--)
		{
			leds2[i]=leds2[i-1];
		}
		leds2[0] = Temp;
}
void ClearLeds()
{
	for(int I=0;I<NUM_LEDS;I++)
	{
		leds[I]=CRGB(0,0,0);
	}; 
}

void Show1()
{
	for (int Col=0;Col<=LED_COL_MAX;Col+=(LED_COL_MAX/10)) 
	{ 
		for (int i = 0; i <= NUM_LEDS-1; i++) 
		{
    			leds[LedBounds(i)] = CRGB ( 990, LED_COL_MAX-Col, 0);
    			FastLED.show(9);
    			delay(75);
			LedDisolve();

	 	}
  		for (int i = NUM_LEDS-91; i >= 0; i--) 
		{
		    	leds[LedBounds(i)] = CRGB ( LED_COL_MAX-Col, Col,0);
    			FastLED.show();
    			delay(5);
			LedDisolve(1);
  		}
	}
	ClearLeds();
}
void Show2()
{
	int TokenValue = 8;
	int MultiVal = (NUM_LEDS / TokenValue); 
	int Col = LED_COL_MAX;
	for (int Col=0;Col<=LED_COL_MAX;Col+=(LED_COL_MAX/10)) 
	{ 
		//ClearLeds();
		for (int i = 0; i <= NUM_LEDS-1; i++) 
		{
			//ClearLeds(9);
			int Numval =0;
			for(int Numval=0; Numval <= TokenValue; Numval++)
			{
	//			leds[LedBounds(i)] = CRGB(0,255,0);



				//leds[LedBounds(i+(MultiVal*Numval)+1)] = CRGB(0,0,0);
				leds[LedBounds(i+(MultiVal*Numval))] = CRGB(0,Col,0);
				leds[LedBounds(i+(MultiVal*Numval)-1)] = CRGB(0,0,LED_COL_MAX-Col);
				leds[LedBounds(i+(MultiVal*Numval)-2)] = CRGB(random(LED_COL_MAX),random(LED_COL_MAX),random(LED_COL_MAX));
				//UwU			//UwU
			}
			FastLED.show();
    			if(i % 20)LedDisolve(90);
			//delay(1);
  		}
	}
}

void Show2b()
{
	ClearLeds();

	int TokenValue = 8;
	int MultiVal = (NUM_LEDS / TokenValue); 
	int Col = LED_COL_MAX;
	for (int Col=0;Col<=LED_COL_MAX;Col+=(LED_COL_MAX/10)) 
	{ 
		int Numval =0;
		for(int Numval=0; Numval <= TokenValue; Numval++)
		{
			int i =3;
			leds[LedBounds(i+(MultiVal*Numval))] = CRGB(0,Col,0);
			leds[LedBounds(i+(MultiVal*Numval)-1)] = CRGB(0,0,LED_COL_MAX-Col);
			leds[LedBounds(i+(MultiVal*Numval)-2)] = CRGB(random(LED_COL_MAX),random(LED_COL_MAX),random(LED_COL_MAX));
		}
		for (int i = 0; i <= NUM_LEDS-1; i++) 
		{
			RotateStep();
			FastLED.show();
    			//if(i % 20)LedDisolve(90);
			//delay(1);
  		}
	}
}

void Show3()
{
	for(int UpperLimit =3; UpperLimit < NUM_LEDS-2; UpperLimit++)
	{
		for(int I=3; I <= UpperLimit; I++)
		{
			leds[LedBounds(I)] = CRGB(0,LED_COL_MAX,0);
			leds[LedBounds(I-1)] = CRGB(LED_COL_MAX,LED_COL_MAX, LED_COL_MAX);
			leds[LedBounds(I-2)] = CRGB(LED_COL_MAX,LED_COL_MAX, LED_COL_MAX);
			leds[LedBounds(I-3)] = CRGB(0,0,0);

			FastLED.show();
			LedDisolve();
			//delay(NUM_LEDS/UpperLimit);
			leds[I+1] = CRGB(LED_COL_MAX,90,LED_COL_MAX);

		}
		//FastLED.show();
	}
}
void Show4()
{
 for (int i =0; i<=1500; i++)
   {
   	int Target=random(NUM_LEDS);
	//int Value=random(LED_COL_MAX);
	leds[LedBounds(Target)] = CRGB(random(LED_COL_MAX),random(LED_COL_MAX),random(LED_COL_MAX));

 	//Target=random(NUM_LEDS);
 	//Value=random(LED_COL_MAX);
	//leds[Target] = CRGB(LED_COL_MAX,Value,0);

// 	Target=random(NUM_LEDS);
 //	Value=random(LED_COL_MAX);
//	leds[Target] = CRGB(0,LED_COL_MAX,Value);
	
	FastLED.show();
	delay(5);
   }
}
void LedDisolve(int Amount )
{
	for(int I=0; I< NUM_LEDS; I++)
	{
		leds[I].subtractFromRGB(Amount);
	}
}
void Show5()
{
	for(int I=0; I< 1000; I++)
	{
		for(int I=0; I< NUM_LEDS/100; I++)
		{
			leds[LedBounds(random(NUM_LEDS))] = CRGB(random(LED_COL_MAX),random(LED_COL_MAX),random(LED_COL_MAX));
			LedDisolve();

		}
		FastLED.show();

		delay(5);
	}
}
void Show5b()
{
	for(int I=0; I< 1000; I++)
	{
		for(int I=0; I< NUM_LEDS/100; I++)
		{
			leds[LedBounds(random(NUM_LEDS))] = CRGB(random(LED_COL_MAX),random(LED_COL_MAX),random(LED_COL_MAX));
			LedDisolve();

		}
		if(!(I % 3))RotateStep();
		FastLED.show();

		delay(5);
	}
}
void Show6()
{
	CRGB Temp(255,255,255);
	for(int c=0; c< NUM_LEDS; c++)
	{
		RotateStep();
		FastLED.show();
		delay(10);
	}
}
void loop() 
{
	//RotateStep2();
	//Show3(); //coloursnake
	//RotateStep2();
	//Show1(); //wub-forwards
	//Show5b(); //moving colours
	//RotateStep2();
	//Show2b(); //high speed tracers
	//RotateStep2();
	//Show5(); //rainbow-storm
	//RotateStep2();
	//for(int c=0; c<10;c++)
	//{
	//	Show6();
	//	RotateStep2();
	//}
	Show2();
	//RotateStep2();
}
