Shader "Custom/blinnPhong"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {} // 어두운 텍스쳐를 하나 입력받으면 스펙큘러가 더 잘 보일 수 있음.

        /*
            블린 퐁 라이팅에서는
            아래의 _SpecColor 라는 프로퍼티가 굉장히 중요함.

            저거는 그냥 평범한 프로퍼티가 아니고,
            유니티에 내장된 블린 퐁 공식 코드를 까보면
            _SpecColor 라는 이름으로 값을 받고 있음.

            그니까 사실상 '예약어'이기 때문에,
            저 이름을 변경해서도 안되고, 
            셰이더 스크립트나 CG 코드에서
            내부적으로 맘대로 사용할 수 없는 변수임.

            정확하게 '_SpecColor' 라고 프로퍼티를 지정해줘야
            정상적으로 스펙큘러가 작동함.
        */
        _SpecColor ("Specular Color", color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BlinnPhong noambient// 라이팅 함수 변경. noambient 를 붙여준 건, 환경광을 제거해서 specular 가 제대로 보이도록 확인하기 위함.

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        // 라이팅 구조체도 SurfaceOutput 으로 변경 (램버트 라이팅에서 사용하는 것과 동일함.)
        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;

            o.Specular = 0.5; // 스펙큘러의 크기를 의미. 1에 가까울수록 작아지고, 0에 가까울수록 커짐.
            o.Gloss = 1; // 스펙큘러의 강도를 의미. 1에 가까울수록 스펙큘러가 선명해지고, 0에 가까울수록 흐릿해짐. 스펙큘러의 opacity(투명도) 조절하는 것과 비슷한 느낌.

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
