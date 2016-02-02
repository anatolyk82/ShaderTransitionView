#ifndef SHADERTRANSITIONVIEW_H
#define SHADERTRANSITIONVIEW_H

#include <QQuickItem>

class ShaderTransitionView : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(ShaderTransitionView)

    Q_PROPERTY(ShaderEffect shaderEffect READ shaderEffect WRITE setShaderEffect NOTIFY shaderEffectChanged)

    Q_ENUMS(ShaderEffect)

public:
    ShaderTransitionView(QQuickItem *parent = 0);
    ~ShaderTransitionView();

    enum ShaderEffect {
        Effect01,
        Effect02,
        Effect03,
        Effect04,
        Effect05,
        Effect06,
        Effect07,
        Effect08,
        Effect09,
        Effect10,
        EffectWIND,
        EffectPINWHEEL,
        EffectCIRCLEOPEN,
        EffectDIRECTIONALWIPE,
        EffectRADIALWIPE,
        EffectPIXELIZE,
        EffectFLIP,
        EffectFOLD,
        EffectDOORWAY,
        EffectFADECOLOR,
        EffectMORPH,
        EffectPOLKADOTS,
        EffectSQUEEZE,
        EffectHORIZONTALSLIDE,
        EffectVERTICALSLIDE

    };
    ShaderEffect shaderEffect() const { return m_shaderEffect;
                                      }
public slots:
    void setShaderEffect(ShaderEffect shaderEffect)
    {
        if (m_shaderEffect == shaderEffect)
            return;

        m_shaderEffect = shaderEffect;
        emit shaderEffectChanged(shaderEffect);
    }

signals:
    void shaderEffectChanged(ShaderEffect shaderEffect);

private:
    ShaderEffect m_shaderEffect;
};

#endif // SHADERTRANSITIONVIEW_H

