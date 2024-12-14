/** @type {import('tailwindcss').Config} */

const colors = require('tailwindcss/colors');

module.exports = {
    content: ['./src/**/*.{html,ts}'],
    theme: {
        container: {
            center: true,
        },
        extend: {
            textShadow: {
                sm: '0 1px 2px var(--tw-shadow-color)',
                DEFAULT: '0 2px 4px var(--tw-shadow-color)',
                lg: '0 8px 16px var(--tw-shadow-color)',
            },
            textOutlineSizes: {
                DEFAULT: '1px',
                sm: '1px',
                md: '2px',
                lg: '3px',
                xl: '4px',
            },
            colors: {
                primary: '#191919',
                secondary: '#292929',
            },
        },
    },
    corePlugins: { preflight: false },
    plugins: [
        function ({ matchUtilities, theme }) {
            matchUtilities(
                {
                    'text-shadow': (value) => ({
                        textShadow: value,
                    }),
                },
                {
                    values: theme('textShadow'),
                }
            );
        },
        function ({ addUtilities, matchUtilities, theme }) {
            const textOutlineSizes = theme('textOutlineSizes');
            const outlineColors = theme('colors');
            const aliases = {
                black: '#000000',
                white: '#ffffff',
            };

            const newUtilities = {};

            newUtilities['.text-outline'] = {
                '--tw-text-outline-color': 'var(--tw-text-opacity, 1)',
            };

            newUtilities['.text-outline'] = {
                textShadow: `
                    -${textOutlineSizes.DEFAULT} -${textOutlineSizes.DEFAULT} 0 var(--tw-text-outline-color),
                    0 -${textOutlineSizes.DEFAULT} 0 var(--tw-text-outline-color),
                    ${textOutlineSizes.DEFAULT} -${textOutlineSizes.DEFAULT} 0 var(--tw-text-outline-color),
                    ${textOutlineSizes.DEFAULT} 0 0 var(--tw-text-outline-color),
                    ${textOutlineSizes.DEFAULT} ${textOutlineSizes.DEFAULT} 0 var(--tw-text-outline-color),
                    0 ${textOutlineSizes.DEFAULT} 0 var(--tw-text-outline-color),
                    -${textOutlineSizes.DEFAULT} ${textOutlineSizes.DEFAULT} 0 var(--tw-text-outline-color),
                    -${textOutlineSizes.DEFAULT} 0 0 var(--tw-text-outline-color)
                `,
            };

            Object.keys(textOutlineSizes).forEach((size) => {
                if (size !== 'DEFAULT') {
                    newUtilities[`.text-outline-${size}`] = {
                        textShadow: `
                            -${textOutlineSizes[size]} -${textOutlineSizes[size]} 0 var(--tw-text-outline-color),
                            0 -${textOutlineSizes[size]} 0 var(--tw-text-outline-color),
                            ${textOutlineSizes[size]} -${textOutlineSizes[size]} 0 var(--tw-text-outline-color),
                            ${textOutlineSizes[size]} 0 0 var(--tw-text-outline-color),
                            ${textOutlineSizes[size]} ${textOutlineSizes[size]} 0 var(--tw-text-outline-color),
                            0 ${textOutlineSizes[size]} 0 var(--tw-text-outline-color),
                            -${textOutlineSizes[size]} ${textOutlineSizes[size]} 0 var(--tw-text-outline-color),
                            -${textOutlineSizes[size]} 0 0 var(--tw-text-outline-color)
                        `,
                    };
                }
            });

            Object.keys(outlineColors).forEach((color) => {
                if (typeof outlineColors[color] === 'object') {
                    Object.keys(outlineColors[color]).forEach((shade) => {
                        newUtilities[`.text-outline-${color}-${shade}`] = {
                            '--tw-text-outline-color':
                                outlineColors[color][shade],
                        };
                    });
                } else {
                    newUtilities[`.text-outline-${color}`] = {
                        '--tw-text-outline-color': outlineColors[color],
                    };
                }
            });

            Object.keys(aliases).forEach((alias) => {
                newUtilities[`.text-outline-${alias}`] = {
                    '--tw-text-outline-color': aliases[alias],
                };
            });

            // matchUtilities(
            //     {
            //         'text-outline': (value) => {
            //             return {
            //                 '--tw-text-outline-color': value,
            //             };
            //         },
            //     },
            //     { values: theme('colors'), type: ['color'] }
            // );

            matchUtilities({
                'text-outline': (value) => {
                    return {
                        '--tw-text-outline-color': value,
                    };
                },
            });

            addUtilities(newUtilities, ['responsive', 'hover']);
        },
    ],
};
