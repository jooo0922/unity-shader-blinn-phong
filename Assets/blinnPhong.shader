Shader "Custom/blinnPhong"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {} // ��ο� �ؽ��ĸ� �ϳ� �Է¹����� ����ŧ���� �� �� ���� �� ����.

        /*
            �� �� �����ÿ�����
            �Ʒ��� _SpecColor ��� ������Ƽ�� ������ �߿���.

            ���Ŵ� �׳� ����� ������Ƽ�� �ƴϰ�,
            ����Ƽ�� ����� �� �� ���� �ڵ带 ���
            _SpecColor ��� �̸����� ���� �ް� ����.

            �״ϱ� ��ǻ� '�����'�̱� ������,
            �� �̸��� �����ؼ��� �ȵǰ�, 
            ���̴� ��ũ��Ʈ�� CG �ڵ忡��
            ���������� ����� ����� �� ���� ������.

            ��Ȯ�ϰ� '_SpecColor' ��� ������Ƽ�� ���������
            ���������� ����ŧ���� �۵���.
        */
        _SpecColor ("Specular Color", color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BlinnPhong noambient// ������ �Լ� ����. noambient �� �ٿ��� ��, ȯ�汤�� �����ؼ� specular �� ����� ���̵��� Ȯ���ϱ� ����.

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        // ������ ����ü�� SurfaceOutput ���� ���� (����Ʈ �����ÿ��� ����ϴ� �Ͱ� ������.)
        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;

            o.Specular = 0.5; // ����ŧ���� ũ�⸦ �ǹ�. 1�� �������� �۾�����, 0�� �������� Ŀ��.
            o.Gloss = 1; // ����ŧ���� ������ �ǹ�. 1�� �������� ����ŧ���� ����������, 0�� �������� �帴����. ����ŧ���� opacity(����) �����ϴ� �Ͱ� ����� ����.

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
