PGDMP                       }            gestion_proyectos    17.4    17.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    16542    gestion_proyectos    DATABASE     w   CREATE DATABASE gestion_proyectos WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';
 !   DROP DATABASE gestion_proyectos;
                     postgres    false            �            1259    16543    company    TABLE     �  CREATE TABLE public.company (
    companynit character varying NOT NULL,
    companyname character varying(255) NOT NULL,
    companyemail character varying(255) NOT NULL,
    companysector character varying(100) NOT NULL,
    contactname character varying(100) NOT NULL,
    contactlastname character varying(100) NOT NULL,
    contactnumber character varying(100) NOT NULL,
    contactposition character varying(100) NOT NULL
);
    DROP TABLE public.company;
       public         heap r       postgres    false            �            1259    16548    coordinator    TABLE     �   CREATE TABLE public.coordinator (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    user_id integer NOT NULL
);
    DROP TABLE public.coordinator;
       public         heap r       postgres    false            �            1259    16551    coordinator_id_seq    SEQUENCE     �   CREATE SEQUENCE public.coordinator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.coordinator_id_seq;
       public               postgres    false    218                       0    0    coordinator_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.coordinator_id_seq OWNED BY public.coordinator.id;
          public               postgres    false    219            �            1259    16574    projects_id_seq    SEQUENCE     x   CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.projects_id_seq;
       public               postgres    false            �            1259    16575    projects    TABLE     �  CREATE TABLE public.projects (
    id integer DEFAULT nextval('public.projects_id_seq'::regclass) NOT NULL,
    name character varying(255),
    description text,
    state character varying(255),
    calificacion integer,
    company_nit character varying(255),
    CONSTRAINT projects_state_check CHECK (((state)::text = ANY (ARRAY['Recibido'::text, 'Aceptado'::text, 'Rechazado'::text])))
);
    DROP TABLE public.projects;
       public         heap r       postgres    false    222            �            1259    16552    user    TABLE     �  CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    role character varying(20) NOT NULL,
    CONSTRAINT user_role_check CHECK (((role)::text = ANY (ARRAY[('ADMIN'::character varying)::text, ('COORDINATOR'::character varying)::text, ('STUDENT'::character varying)::text, ('COMPANY'::character varying)::text])))
);
    DROP TABLE public."user";
       public         heap r       postgres    false            �            1259    16556    user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public               postgres    false    220                       0    0    user_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;
          public               postgres    false    221            e           2604    16557    coordinator id    DEFAULT     p   ALTER TABLE ONLY public.coordinator ALTER COLUMN id SET DEFAULT nextval('public.coordinator_id_seq'::regclass);
 =   ALTER TABLE public.coordinator ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    218            f           2604    16558    user id    DEFAULT     d   ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    220                      0    16543    company 
   TABLE DATA           �   COPY public.company (companynit, companyname, companyemail, companysector, contactname, contactlastname, contactnumber, contactposition) FROM stdin;
    public               postgres    false    217   E"       	          0    16548    coordinator 
   TABLE DATA           8   COPY public.coordinator (id, name, user_id) FROM stdin;
    public               postgres    false    218   �#                 0    16575    projects 
   TABLE DATA           [   COPY public.projects (id, name, description, state, calificacion, company_nit) FROM stdin;
    public               postgres    false    223   �#                 0    16552    user 
   TABLE DATA           ;   COPY public."user" (id, email, password, role) FROM stdin;
    public               postgres    false    220   X%                  0    0    coordinator_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.coordinator_id_seq', 2, true);
          public               postgres    false    219                       0    0    projects_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.projects_id_seq', 10, true);
          public               postgres    false    222                       0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 4, true);
          public               postgres    false    221            k           2606    16560     company company_companyemail_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_companyemail_key UNIQUE (companyemail);
 J   ALTER TABLE ONLY public.company DROP CONSTRAINT company_companyemail_key;
       public                 postgres    false    217            m           2606    16562    company company_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (companynit);
 >   ALTER TABLE ONLY public.company DROP CONSTRAINT company_pkey;
       public                 postgres    false    217            o           2606    16564    coordinator coordinator_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.coordinator
    ADD CONSTRAINT coordinator_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.coordinator DROP CONSTRAINT coordinator_pkey;
       public                 postgres    false    218            u           2606    16583    projects projects_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
       public                 postgres    false    223            q           2606    16566    user user_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_key;
       public                 postgres    false    220            s           2606    16568    user user_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public                 postgres    false    220            v           2606    16569    coordinator fk_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.coordinator
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.coordinator DROP CONSTRAINT fk_user;
       public               postgres    false    220    4723    218               E  x�m��n�0���S��H!n���61��]�4�Ni\�́����N<B_li�I�/Y����k�ě�z�6?���b����:s��\p���JkK���t&��$�$�scx���d]�T�hNP�>Y
���ɧ�[<����+�� Mޒ�>a<�LE4�/`��1ؑvuN���|Ҳ������J�th~���6g��Aqײ UV�Z�2ʢf��,�I��Q���AL���Ǯ!}ݡw�]/h[v�\�+�]r�o&�A�������=H2�^ГU���;�7$ʼ���j�`�\�+{��b"��3��Jb֜�\{1�� �١�      	      x������ � �         �  x���Mn1��ݧ�	��뙞e EH!V(�wA�]V�=�܆�@9B_wO�=C�l�ޫ�U-��?PGV���P�` 6�U�jp��Ҡi|pʎG2ʃ���!Ώ�_AW�G�t������r��4�]��W��F�n�7h��G��H
-L�R��q�)�I�Z����ۦڷ�m�Y���:�kS
8�~J�D��r�lQ4�B�J$ِ���'�MS����7hR�S�m�Jӥ��A�S��zV�̜j����&o| ��s�Q,M0f�!��H��/�Ĵ_������ �	)Q?XpJ`͢ �+�����;N�$P�0��9�фK��l���OĲ�Ȃ|������}V����
�t]B��	��C8[���r��߁�/$�k/�����(NM         �   x�3�L��/J��K,�/rH�H�-�I�K�υ�s:���x�9��qs����敠(���������p� ��$�U��	������e�i�i���r���;��e&'�&'��")2�,�������7�`C����kc���� �SC     