# Макет лендинга Personal CRM

Материалы для вёрстки: статичная страница на Astro + Tailwind CSS 4.
Макет утверждён: мобильная версия (вариант 5, «Лендинг целиком») и десктопная версия.

## Что в папке

| Файл | Что это |
|---|---|
| `mobile.html` | Образец мобильной версии, ширина 390 px. Открыть в браузере — это эталон вида |
| `desktop.html` | Образец десктопной версии, ширина 1440 px, контент в контейнере 1200 px |
| `icons/` | SVG-иконки (`stroke="currentColor"`, 24×24) и `favicon.svg` |
| `README.md` | Этот файл: токены, адаптив, блоки, тексты, приёмка |

Кто прав при расхождении: `CLAUDE.md` в корне → этот README → HTML-образцы.
HTML-образцы подключают шрифты с Google Fonts только для просмотра — в проекте шрифты подключаются по разделу «Шрифты».

## Задача в двух словах

- Одна страница, одно целевое действие — перейти в приложение.
- Кнопка «Открыть приложение» встречается дважды: на первом экране и в финальном блоке. Обе ведут на адрес приложения `https://app.<домен>` (домен уточнить у владельца), в той же вкладке.
- Адрес приложения хранится в одном месте — константа `APP_URL` в `src/config.ts`.
- Без клиентского JavaScript, без форм, без аналитики (аналитика — отдельное решение владельца).
- Картинок нет: всё сделано разметкой, CSS и SVG-иконками.

## Адаптив

Вёрстка mobile-first, одна страница для всех ширин.

| Ширина | Раскладка |
|---|---|
| < 1024 px | Мобильная, как `mobile.html`. Контент ограничен `max-w-narrow` (560 px) и центрирован — на планшете не растягивается |
| ≥ 1024 px (`lg:`) | Десктопная, как `desktop.html`. Контейнер `max-w-page` (1200 px), поля по бокам 40 px |

Проверять без горизонтальной прокрутки на ширинах 320, 390, 768, 1024, 1440, 1920.

## Токены

Все цвета, шрифты, размеры текста, отступы и скругления — только из `src/styles/tokens.css`. Готовый файл ниже: скопировать как есть.
В компонентах никаких hex-кодов и «магических» px: если нужного значения нет — добавить токен, а не писать значение в разметке.
Мелкие размеры внутри иллюстраций, которых нет в шкале, брать по ближайшему токену (расхождение до 2 px допустимо).

Подключение: `src/styles/global.css`

```css
@import "tailwindcss";
@import "./tokens.css";
```

`src/styles/tokens.css`

```css
/* Design tokens for the Personal CRM landing (Tailwind CSS 4).
   Values come from design/README.md. Suffix -lg = desktop value, used with the lg: variant (>= 1024px). */
@theme {
  /* Fonts */
  --font-display: "Unbounded Variable", "Unbounded", sans-serif;
  --font-sans: "Onest Variable", "Onest", system-ui, sans-serif;

  /* Base palette (palette 40) */
  --color-ink: #1B2963;
  --color-plum: #58304C;
  --color-ochre: #976824;
  --color-rose: #A85A78;
  --color-dusty: #E9D3CA;

  /* Surfaces */
  --color-paper: #F5ECE7;
  --color-card: #FFFBF8;
  --color-blush: #F3E6E0;
  --color-bubble: #EFE3DD;

  /* Text on light surfaces */
  --color-ink-soft: #3D4570;
  --color-muted: #5A5F80;
  --color-plum-ink: #3A1F33;
  --color-bubble-ink: #6A5F78;

  /* Lines */
  --color-line: #D9C6BE;
  --color-divider: #E6D6CF;

  /* Inside the navy panel (Problem) */
  --color-navy-raised: #26357D;
  --color-navy-chip: #2A3A85;
  --color-navy-avatar: #3A4A93;
  --color-navy-line: #5A68AD;
  --color-on-navy: #D5D9EE;
  --color-on-navy-label: #C9CDE6;
  --color-on-navy-muted: #AEB4DA;
  --color-rose-light: #F0B9CC;

  /* Inside plum surfaces */
  --color-plum-raised: #6E4362;
  --color-plum-hover: #48273E; /* proposal: hover state, not drawn in the mockup */
  --color-on-plum: #E9CFC5;
  --color-on-plum-accent: #F3D9E3;

  /* Inside ochre surfaces */
  --color-ochre-raised: #A97B3A;
  --color-on-ochre: #F6E6CC;
  --color-on-ochre-accent: #FFF3DF;

  /* Type scale */
  --text-h1: 1.875rem;
  --text-h1--line-height: 1.16;
  --text-h1--letter-spacing: -0.025em;
  --text-h1-lg: 3.375rem;
  --text-h1-lg--line-height: 1.12;
  --text-h1-lg--letter-spacing: -0.03em;

  --text-h2: 1.375rem;
  --text-h2--line-height: 1.25;
  --text-h2--letter-spacing: -0.02em;
  --text-h2-lg: 2.25rem;
  --text-h2-lg--line-height: 1.22;
  --text-h2-lg--letter-spacing: -0.02em;

  --text-cta: 1.6875rem;
  --text-cta--line-height: 1.2;
  --text-cta--letter-spacing: -0.025em;
  --text-cta-lg: 3rem;
  --text-cta-lg--line-height: 1.15;
  --text-cta-lg--letter-spacing: -0.03em;

  --text-statement: 1.125rem;
  --text-statement--line-height: 1.3;
  --text-statement-lg: 1.375rem;
  --text-statement-lg--line-height: 1.3;

  --text-callout: 0.9375rem;
  --text-callout--line-height: 1.35;
  --text-callout-lg: 1.125rem;
  --text-callout-lg--line-height: 1.35;

  --text-tile-title: 0.875rem;
  --text-tile-title--line-height: 1.3;
  --text-tile-title-lg: 1.125rem;
  --text-tile-title-lg--line-height: 1.3;

  --text-lead: 1rem;
  --text-lead--line-height: 1.5;
  --text-lead-lg: 1.1875rem;
  --text-lead-lg--line-height: 1.55;

  --text-body: 1rem;
  --text-body--line-height: 1.5;
  --text-body-lg: 1.125rem;
  --text-body-lg--line-height: 1.55;

  --text-tile: 0.875rem;
  --text-tile--line-height: 1.4;
  --text-tile-lg: 1.0625rem;
  --text-tile-lg--line-height: 1.4;

  --text-name: 0.9375rem;
  --text-name-lg: 1.1875rem;

  --text-number: 1.875rem;
  --text-number--line-height: 1;
  --text-number--letter-spacing: -0.03em;
  --text-number-lg: 2.75rem;
  --text-number-lg--line-height: 1;
  --text-number-lg--letter-spacing: -0.03em;

  --text-button: 1.0625rem;
  --text-button-lg: 1.125rem;

  --text-bubble: 1rem;
  --text-bubble-lg: 1.0625rem;

  --text-caption: 0.8125rem;
  --text-caption-lg: 0.9375rem;

  --text-chip: 0.8125rem;
  --text-chip-lg: 0.875rem;

  --text-label: 0.6875rem;
  --text-label--letter-spacing: 0.06em;
  --text-label-lg: 0.75rem;
  --text-label-lg--letter-spacing: 0.06em;

  --text-logo: 0.9375rem;
  --text-logo-lg: 1.0625rem;

  /* Spacing */
  --spacing-gutter: 1.25rem;      /* 20px: page side padding on mobile */
  --spacing-gutter-card: 0.875rem; /* 14px: hero card side margin on mobile */
  --spacing-edge: 0.5rem;          /* 8px: dark panels side margin on mobile */
  --spacing-gutter-lg: 2.5rem;     /* 40px: page side padding on desktop */
  --spacing-section: 3.25rem;      /* 52px: between sections on mobile */
  --spacing-section-lg: 7rem;      /* 112px: between sections on desktop */
  --spacing-columns: 3.5rem;       /* 56px: gap between desktop columns */

  /* Widths */
  --container-page: 75rem;   /* 1200px */
  --container-narrow: 35rem; /* 560px: mobile layout on tablets */

  /* Radii */
  --radius-tile: 1.25rem;
  --radius-tile-lg: 1.5rem;
  --radius-card: 1.75rem;
  --radius-card-lg: 2.25rem;
  --radius-panel: 2rem;
  --radius-panel-lg: 2.5rem;
  --radius-benefit: 1.5rem;
  --radius-benefit-lg: 1.875rem;
  --radius-button: 1rem;
  --radius-button-lg: 1.125rem;
}
```

### Цвета: где какой

| Токен | Hex | Где |
|---|---|---|
| `paper` | #F5ECE7 | Фон страницы; фон светлой кнопки в финале |
| `ink` | #1B2963 | Основной текст; тёмно-синяя панель «Проблема»; синие плитки |
| `plum` | #58304C | Основная кнопка; слово «человека»; панель финала; плитка выгоды 01 |
| `ochre` | #976824 | Плитка даты; выгода 03; подчёркивание «человека»; «но и» |
| `rose` | #A85A78 | Аватар «АС»; чип «Как прошёл?»; пузырь «Как прошёл марафон?»; зачёркивание |
| `dusty` | #E9D3CA | Плитки «Важно помнить», «Интересы»; чип «Решение»; строка «Перед встречей…» |
| `card` | #FFFBF8 | Белые панели: карточка контакта, панель решения, выгода 02 |
| `blush` | #F3E6E0 | Плитки «Говорили о», «Любые заметки»; плашка «02» |
| `ink-soft` | #3D4570 | Подзаголовок первого экрана |
| `muted` | #5A5F80 | Подписи «Бесплатно», должность, «а не с», текст чипов ФИО/Телефон/Почта |
| остальные | — | Оттенки внутри цветных панелей, см. комментарии в `tokens.css` |

Контраст всех пар «текст/фон» из макета проверен: обычный текст ≥ 4,5:1, крупный ≥ 3:1. Новые пары проверять так же.

## Шрифты

- **Unbounded** (500, 600, 700) — заголовки, логотип, имя в карточке, цифры, номера выгод, тексты выгод и плиток решения, плашка «Становится неловко…».
- **Onest** (400, 500, 600) — всё остальное: подзаголовок, абзацы, кнопки, подписи, чипы, метки плиток.
- Нужна кириллица. У Unbounded нет курсива — курсив нигде не используется.

Как подключить — решает владелец (по `CLAUDE.md` новые библиотеки и сервисы согласуются):

1. **Рекомендуется:** пакеты Fontsource, шрифты лежат в сборке, внешних запросов нет — `@fontsource-variable/unbounded` (5.3.0) и `@fontsource-variable/onest` (5.3.1), импорт в `Base.astro`. Названия семейств уже прописаны в токенах: `"Unbounded Variable"`, `"Onest Variable"`.
2. Ссылка на Google Fonts, как в HTML-образцах, — без новых пакетов, но с запросами к Google.

Версии проверены 14.10.2026; на тот момент актуальны astro 7.3.8, tailwindcss и @tailwindcss/vite 4.3.3.

## Общие элементы

**Кнопка «Открыть приложение»** — компонент `AppButton.astro`, это ссылка `<a href={APP_URL}>`, не `<button>`.

| | Основная (первый экран) | Светлая (финал) |
|---|---|---|
| Фон / текст | `plum` / белый | `paper` / `plum` |
| Высота | 58 px, на `lg` 64 px | 58 px, на `lg` 64 px |
| Ширина | на мобильном во всю ширину; на `lg` по содержимому, поля 32 px | во всю ширину блока, на `lg` не шире 380 px |
| Шрифт | Onest 600, `text-button` → `lg:text-button-lg` | так же |
| Скругление | `rounded-button` → `lg:rounded-button-lg` | так же |
| Иконка | `arrow-right` 20 px (22 на `lg`) справа от текста, отступ 10–12 px | так же |
| Наведение (предложение) | фон `plum-hover` | фон `card` |
| Фокус (предложение) | обводка 3 px `ochre`, отступ 3 px, только `:focus-visible` | так же |

Под каждой кнопкой подпись «Бесплатно» (`text-caption`, цвет `muted`; в финале `on-plum`). На первом экране десктопа подпись стоит справа от кнопки в одну строку.

**Плитка** — скруглённый блок с меткой сверху: иконка 14 px (16 на `lg`) + метка Onest 600, `text-label`, заглавными буквами. Содержимое прижато к низу (`justify-between`). Скругление `rounded-tile`.

**Чип-метка блока** («Знакомо?», «Решение») — Onest 600, `text-chip`, поля 6×12 px (7×14 на `lg`), полностью скруглён.

**Иконки** — из `design/icons/`, вставлять инлайном через компонент `Icon.astro`, цвет через `currentColor`. Декоративные иконки — `aria-hidden="true"`.

## Блоки по порядку

Точные отступы и размеры — в HTML-образцах. Ниже — состав блока и что меняется на десктопе.

### 1. Шапка

Знак логотипа (квадрат `plum` 34 px, скругление 10 px, внутри `logo-mark` 20 px цвета `on-plum`) + слово «Personal CRM» (Unbounded 600, `text-logo`). Отступ сверху 18 px.
**Десктоп:** знак 40 px, скругление 12 px, иконка 22 px, `lg:text-logo-lg`, отступ сверху 28 px. Кнопки в шапке нет.

### 2. Первый экран

Состав: заголовок H1 → подзаголовок → кнопка → «Бесплатно» → карточка контакта (иллюстрация).
- H1: Unbounded 600, `text-h1`. Слово «человека» — цвет `plum`, подчёркивание `ochre` толщиной 4 px с отступом 7 px (на `lg` 6 px и 10 px).
- Подзаголовок: `text-lead`, цвет `ink-soft`.
- Карточка контакта: панель `card`, скругление `rounded-card`, внутри строка профиля (аватар 50 px `rose` с инициалами, имя Unbounded `text-name`, строка «должность · телефон» `muted`) и сетка 2×2 плиток:
  - «Знакомство» — фон `ink`, иконка `map-pin`;
  - «День рождения» — фон `ochre`, иконка `calendar`, крупное «12» (Unbounded 700, `text-number`) и «марта» под ним;
  - «Важно помнить» — фон `dusty`, иконка `heart`;
  - «Говорили о» — фон `blush`, иконка `message`, внизу чип «Как прошёл?» (`rose`, белый текст).
- На мобильном карточка шире текста: поля по бокам 14 px вместо 20.

**Десктоп:** две колонки равной ширины, между ними 56 px, по вертикали по центру. Слева текст, справа карточка. H1 `lg:text-h1-lg`, подзаголовок `lg:text-lead-lg`, не шире 520 px. Отступ сверху 72 px. Плитки карточки — минимальная высота 150 px, поля 20 px, `lg:rounded-tile-lg`; аватар 60 px; панель `lg:rounded-card-lg`.

### 3. Проблема

Тёмно-синяя панель (`ink`), скругление `rounded-panel`. Состав: чип «Знакомо?» (фон `navy-chip`, текст `rose-light`) → H2 (белый) → список трёх контактов → абзац (`on-navy`) → плашка-вывод (фон `navy-chip`, иконка `face-sad` и текст Unbounded 500 `text-callout` цвета `rose-light`).
Строка контакта: фон `navy-raised`, аватар-заглушка (`navy-avatar`, иконка `user`), имя белым Onest 600, под ним «Нет заметок» (`on-navy-muted`), справа кружок «?» с обводкой `navy-line`.
**Мобильный:** панель почти во всю ширину — поля по бокам 8 px (`edge`), внутренние отступы 28×18 px.
**Десктоп:** в контейнере, внутренние отступы 64 px, `lg:rounded-panel-lg`. Две колонки: слева чип, H2, абзац, плашка; справа список. Порядок разный, поэтому раскладывать сеткой с `grid-template-areas`, а не дублировать разметку:
- мобильный: `chip / title / list / text / callout`;
- десктоп: слева `chip, title, text, callout`, справа `list` на всю высоту, по вертикали по центру.

### 4. Решение

Состав: чип «Решение» (`dusty` / `plum`) → H2 → белая панель → строка «Перед встречей…».
- В белой панели три чипа с обводкой `line` («ФИО», «Телефон», «Почта»), под ними разделитель: линия `divider` — «но и» (Unbounded 600, `ochre`) — линия. Ниже четыре плитки:
  - «История знакомства» — `ink`, иконка `map-pin`;
  - «Интересы» — `dusty`, вверху чипы «бег» и «джаз» на фоне `card`;
  - «Важные даты» — `ochre`, иконка `calendar`;
  - «Любые заметки» — `blush`, иконка `pencil` цвета `rose`.
  Название плитки — Unbounded 600, `text-tile-title`, внизу плитки.
- Строка «Перед встречей…»: фон `dusty`, слева квадрат `plum` 36 px с иконкой `contact-card`, текст `text-lead` 500, цвет `plum-ink`.
- На мобильном белая панель и строка выступают на 6 px за поля текста.

**Десктоп:** чипы и разделитель «но и» в одну строку; плитки в ряд по четыре, минимальная высота 180 px, иконки 28 px, `lg:text-tile-title-lg`; квадрат с иконкой 48 px.

### 5. Выгоды

Состав: H2 «Что вы получаете» → три плитки. Номер «01/02/03» — плашка Unbounded 600, 12 px (13 на `lg`).
- 01 — фон `plum`, плашка `plum-raised` / `on-plum-accent`, текст Unbounded 500 `text-statement` белым.
- 02 — фон `card`, плашка `blush` / `plum`. Внутри фраза собрана из частей: «Разговор начинается с» (Unbounded 500, `text-statement`) → пузырь `rose` с белым текстом «Как прошёл марафон?» и иконкой `check` → «а не с» (`muted`) → пузырь `bubble` с текстом `bubble-ink`, зачёркнутым линией `rose` («Напомни, где мы виделись?»). Пузыри: поля 12×16 px, скругление 20 px, кроме нижнего левого угла 6 px.
- 03 — фон `ochre`, плашка `ochre-raised` / `on-ochre-accent`, текст белым.
- Скругление `rounded-benefit`. На мобильном плитки друг под другом и выступают на 6 px за поля текста.

**Десктоп:** три плитки в ряд одной высоты (минимум 300 px), номер сверху, текст прижат к низу; в плитке 02 содержимое прижато к низу. `lg:text-statement-lg`, `lg:rounded-benefit-lg`.

### 6. Призыв к действию

Панель `plum`, скругление `rounded-panel`. Состав: ряд из четырёх аватаров-кружков 44 px с инициалами, наложенных друг на друга на 10 px, с обводкой 3 px цвета `plum` (фоны: `rose`, `ochre`, `ink`, `dusty`) → H2 белым (Unbounded 600, `text-cta`) → светлая кнопка → «Бесплатно» (`on-plum`).
**Мобильный:** выравнивание по левому краю, поля по бокам 8 px, кнопка во всю ширину. Это последний элемент страницы, подвала нет.
**Десктоп:** всё по центру, внутренние отступы 80×64 px, `lg:rounded-panel-lg`, аватары 56 px (наложение 12 px, обводка 4 px), H2 `lg:text-cta-lg` не шире 760 px, кнопка не шире 380 px.

## Тексты (дословно)

Тексты берутся отсюда, без правок. Менять — только с согласия владельца.

**Шапка**
- Personal CRM *(рабочее название продукта — уточнить)*

**Первый экран**
- H1: Помните не только номер, но и человека
- Подзаголовок: Записная книжка, в которой хранится главное о ваших знакомых: как вы встретились, что для них важно, о чём вы говорили.
- Кнопка: Открыть приложение
- Подпись: Бесплатно
- Карточка (демо-данные для иллюстрации): АС · Андрей Соколов · Дизайнер интерфейсов · +7 900 000-00-00 · Знакомство — Конференция в Казани, май 2024 · День рождения — 12 марта · Важно помнить — Жена Марина, сын Тёма, 6 лет · Говорили о — Марафоне в октябре · Как прошёл?

**Проблема**
- Чип: Знакомо?
- H2: В телефоне сотни контактов, а за многими из них только имя
- Список: Андрей Сервис · Марина (свадьба) · Олег??? — у каждого «Нет заметок» и «?»
- Абзац: Вы встречаете человека через год и не можете вспомнить, откуда его знаете, как зовут его жену и чем он занимается.
- Плашка: Становится неловко, а отношения остывают

**Решение**
- Чип: Решение
- H2: К каждому контакту можно добавить не только ФИО, телефон и почту
- Чипы: ФИО · Телефон · Почта
- Разделитель: но и
- Плитки: История знакомства · Интересы (чипы: бег, джаз) · Важные даты · Любые заметки
- Строка: Перед встречей достаточно открыть карточку, и все детали снова под рукой.

**Выгоды**
- H2: Что вы получаете
- 01: Вы не теряете людей, которые для вас важны
- 02: Разговор начинается с · «Как прошёл марафон?» · а не с · «Напомни, где мы виделись?»
- 03: Знакомые чувствуют внимание, и это укрепляет отношения

**Призыв к действию**
- Аватары (декор): АС · МК · ОП · ТН
- H2: Начните помнить людей, а не номера
- Кнопка: Открыть приложение
- Подпись: Бесплатно

**Отличия от `landing-text.md` (так утверждено в макете):** кнопка «Открыть приложение» вместо «Скачать бесплатно», а «Бесплатно» вынесено в подпись; добавлены чипы «Знакомо?», «Решение» и заголовок «Что вы получаете»; абзацы «Проблема» и «Решение» разбиты на заголовок, иллюстрацию и текст; у заголовков и плашки нет точки в конце.

**Мета-теги (предложение, согласовать с владельцем):** `<title>` — «Помните не только номер, но и человека — Personal CRM»; `description` — текст подзаголовка; `lang="ru"`; иконка вкладки — `icons/favicon.svg`. Картинки для соцсетей (Open Graph) в макете нет — спросить владельца.

## Разметка и доступность

- Один `<h1>`, у каждого блока свой `<h2>`; блоки — `<section aria-labelledby="…">` внутри `<main>`.
- Карточка контакта на первом экране и аватары в финале — иллюстрации: обёртка с `aria-hidden="true"`.
- Список контактов в «Проблеме» — `<ul>`, кружки «?» и иконки — `aria-hidden="true"`.
- Плитки решения — `<ul>`; выгоды — `<ol>`, номера «01–03» — `aria-hidden="true"`.
- Зачёркнутый пузырь — тег `<s>`.
- Кнопки — ссылки, размер касания не меньше 44×44 px, видимый фокус.
- Анимаций в макете нет.

## Структура проекта (предложение)

```
src/
  config.ts                // APP_URL
  styles/tokens.css        // the @theme block above
  styles/global.css        // @import "tailwindcss"; @import "./tokens.css";
  layouts/Base.astro       // <html lang="ru">, meta, fonts, global.css
  components/
    Header.astro
    Hero.astro
    ContactCardMock.astro
    Problem.astro
    Solution.astro
    Benefits.astro
    FinalCta.astro
    AppButton.astro        // variant: "primary" | "light"
    Icon.astro             // inline SVG from design/icons
  pages/index.astro
public/
  favicon.svg              // copy of design/icons/favicon.svg
```

Tailwind 4 в Astro подключается через Vite-плагин `@tailwindcss/vite` (команда `pnpm astro add tailwind` делает это сама).

## Готово, когда

- На 390 px страница выглядит как `mobile.html`, на 1440 px — как `desktop.html`. Сравнить скриншоты рядом.
- На ширинах 320–1920 px нет горизонтальной прокрутки, ничего не обрезано и не наезжает.
- Все тексты совпадают с разделом «Тексты» дословно.
- Обе кнопки ведут на `APP_URL`.
- В компонентах нет hex-кодов и произвольных px — только токены.
- На страницу не попадает клиентский JavaScript.
- Lighthouse для мобильного: Performance, Accessibility, Best Practices, SEO — не ниже 95.
