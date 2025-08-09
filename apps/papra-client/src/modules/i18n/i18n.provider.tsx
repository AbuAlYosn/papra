import type { Accessor, ParentComponent, Setter } from 'solid-js';
import type { LocaleKeys } from './locales.types';
import { makePersisted } from '@solid-primitives/storage';
import { createContext, createEffect, createResource, createSignal, Show, useContext } from 'solid-js';
import defaultDict from '../../locales/en.yml';
import { locales } from './i18n.constants';
import { createFragmentTranslator, createTranslator, findMatchingLocale } from './i18n.models';

export type Locale = typeof locales[number]['key'];
type Dictionary = Record<LocaleKeys, string>;

const I18nContext = createContext<{
  t: ReturnType<typeof createTranslator<Dictionary>>;
  te: ReturnType<typeof createFragmentTranslator<Dictionary>>;
  getLocale: Accessor<Locale>;
  setLocale: Setter<Locale>;
  locales: typeof locales;
}>();

export function useI18n() {
  const context = useContext(I18nContext);

  if (!context) {
    throw new Error('I18n context not found, useI18n must be used within I18nProvider');
  }

  return context;
}

async function fetchDictionary(locale: Locale): Promise<Dictionary> {
  const { default: dict } = await import(`../../locales/${locale}.yml`);

  return {
    ...defaultDict,
    ...dict,
  };
}

export const I18nProvider: ParentComponent = (props) => {
  const browserLocale = findMatchingLocale({
    preferredLocales: navigator.languages.map(x => new Intl.Locale(x)),
    supportedLocales: locales.map(x => new Intl.Locale(x.key)),
  });
  const [getLocale, setLocale] = makePersisted(createSignal<Locale>(browserLocale), { name: 'papra_locale', storage: localStorage });

  const [dict] = createResource(getLocale, fetchDictionary);

  createEffect(() => {
    const currentLocale = getLocale();
    const localeConfig = locales.find(locale => locale.key === currentLocale);
    
    document.documentElement.lang = currentLocale;
    document.documentElement.dir = localeConfig?.rtl ? 'rtl' : 'ltr';
    
    // Update CSS custom property for RTL support
    document.documentElement.style.setProperty('--text-direction', localeConfig?.rtl ? 'rtl' : 'ltr');
  });

  return (
    <Show when={dict.latest}>
      {getDictionary => (
        <I18nContext.Provider
          value={{
            t: createTranslator({ getDictionary }),
            te: createFragmentTranslator({ getDictionary }),
            getLocale,
            setLocale,
            locales,
          }}
        >
          {props.children}
        </I18nContext.Provider>
      )}
    </Show>
  );
};
